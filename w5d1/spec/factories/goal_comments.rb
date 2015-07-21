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

FactoryGirl.define do
  factory :goal_comment do
    user nil
goal nil
body "MyText"
  end

end
