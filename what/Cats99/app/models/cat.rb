# == Schema Information
#
# Table name: cats
#
#  id          :integer          not null, primary key
#  name        :string           not null
#  birth_date  :date
#  color       :string           not null
#  sex         :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'date'

class Cat < ActiveRecord::Base
  validates :name, :color, presence: true
  validates :sex, length: {is: 1}
  validate :sex_is_correct
  validate :color_is_correct

  has_many(
    :rental_requests,
    class_name: :CatRentalRequest,
    foreign_key: :cat_id,
    primary_key: :id,
    dependent: :destroy
  )

  def age
    now = Time.now.utc.to_date
    now.year - birth_date.year - ((now.month > birth_date.month ||
      (now.month == birth_date.month && now.day >= birth_date.day)) ? 0 : 1)
  end


  private

  def sex_is_correct
    unless ['m', 'f'].include?(sex.downcase)
      errors[:sex] << "must be 'M' or 'F'"
    end
  end

  def color_is_correct
    cat_colors = ['brown', 'black', 'white', 'gray', 'orange']
    unless cat_colors.include?(color.downcase)
      errors[:color] << "must be a normal cat color"
    end
  end
end
