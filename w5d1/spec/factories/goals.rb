# == Schema Information
#
# Table name: goals
#
#  id         :integer          not null, primary key
#  text       :string           not null
#  privateer  :boolean          default(TRUE), not null
#  completed  :boolean          default(FALSE), not null
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :goal do
    text { Faker::Hacker.say_something_smart }

    factory :public_goal do
      privateer false
    end
  end

end
