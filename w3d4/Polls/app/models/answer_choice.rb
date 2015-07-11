# == Schema Information
#
# Table name: answer_choices
#
#  id          :integer          not null, primary key
#  text        :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  question_id :integer          not null
#

class AnswerChoice < ActiveRecord::Base
  validates :question_id, :presence => true

  belongs_to(
    :question,
    primary_key: :id,
    foreign_key: :question_id,
    class_name: :Question
  )

  has_many(
    :responses,
    primary_key: :id,
    foreign_key: :answer_choice_id,
    class_name: :Response
  )

  has_many(
    :users,
    through: :responses,
    source: :respondent
  )

end
