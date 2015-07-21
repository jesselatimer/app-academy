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

require 'rails_helper'

RSpec.describe Goal, type: :model do
  it { should validate_presence_of(:text) }
  it { should validate_presence_of(:user) }
  it { should belong_to(:user) }

end
