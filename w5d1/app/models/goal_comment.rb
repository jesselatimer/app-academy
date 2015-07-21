# == Schema Information
#
# Table name: goal_comments
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  goal_id    :integer
#  body       :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class GoalComment < ActiveRecord::Base
  belongs_to :author, class_name: :User
  belongs_to :goal
end
