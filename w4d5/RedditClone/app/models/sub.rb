# == Schema Information
#
# Table name: subs
#
#  id          :integer          not null, primary key
#  title       :string           not null
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Sub < ActiveRecord::Base
  validates :title, presence: true, uniqueness: true
  has_many :mod_subs
  has_many :post_subs
  has_many :mods, through: :mod_subs
  has_many :posts, through: :post_subs
end
