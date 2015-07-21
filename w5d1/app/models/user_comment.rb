# == Schema Information
#
# Table name: user_comments
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  body       :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  author_id  :integer          not null
#

class UserComment < ActiveRecord::Base
  belongs_to :user
  belongs_to(
    :author,
    class_name: :User
  )
end
