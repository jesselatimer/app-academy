# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  user_name  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ActiveRecord::Base
  validates :user_name, :uniqueness => true

  has_many(
    :author_polls,
    primary_key: :id,
    foreign_key: :author_id,
    class_name: :Poll
  )

  has_many(
    :responses,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :Response
  )

  has_many(
    :answer_choices,
    through: :responses,
    source: :answer_choice
  )

end
