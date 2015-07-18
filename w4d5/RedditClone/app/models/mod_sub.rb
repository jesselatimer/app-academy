# == Schema Information
#
# Table name: mod_subs
#
#  id         :integer          not null, primary key
#  sub_id     :integer          not null
#  mod_id     :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ModSub < ActiveRecord::Base
  validate :unique_mod_for_sub
  validates :sub, :mod, :username, presence: true
  belongs_to :sub
  belongs_to :mod, class_name: :User
  attr_reader :username

  def username=(username)
    @username = username
    user = User.find_by(username: username)
    if user
      self.mod_id = user.id
    else
      self.mod_id = nil
    end
  end

  def unique_mod_for_sub
    if ModSub.find_by(sub_id: sub_id, mod_id: mod_id)
      errors[:mod] << "is already a mod"
    end
  end
end
