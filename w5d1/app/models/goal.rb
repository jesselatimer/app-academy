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

class Goal < ActiveRecord::Base
  validates :user, :text, presence: true
  belongs_to :user
end
