# == Schema Information
#
# Table name: responses
#
#  id               :integer          not null, primary key
#  user_id          :integer          not null
#  answer_choice_id :integer          not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Response < ActiveRecord::Base
  validates :user_id, :answer_choice_id, :presence => true
  validate :respondent_has_not_already_answered_question,
           :respondent_is_not_poll_author

  belongs_to(
    :respondent,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User
  )

  belongs_to(
    :answer_choice,
    primary_key: :id,
    foreign_key: :answer_choice_id,
    class_name: :AnswerChoice
  )

  has_one(
    :question,
    through: :answer_choice,
    source: :question
  )

  has_one(
    :poll,
    through: :question,
    source: :poll
  )

  def sibling_responses
    question.responses.where("? IS NULL OR ? != responses.id", id, id)
  end

  private
  def respondent_has_not_already_answered_question
    unless sibling_responses.where("responses.user_id = ?", user_id).count == 0
      errors[:user_id] << "has already responded to this question"
    end
  end

  def respondent_is_not_poll_author
    if question.poll.author_id == user_id
      errors[:user_id] << "created this poll and may not answer"
    end
  end
end
