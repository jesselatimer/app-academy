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

require 'rails_helper'

RSpec.describe GoalComment, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
