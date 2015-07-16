# == Schema Information
#
# Table name: albums
#
#  id         :integer          not null, primary key
#  title      :string           not null
#  studio     :string           not null
#  band_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Album < ActiveRecord::Base
  validates :title, :studio, :band, presence: true

  belongs_to(
    :band,
    foreign_key: :band_id,
    primary_key: :id,
    class_name: :Band
  )

  has_many(
    :tracks,
    foreign_key: :album_id,
    primary_key: :id,
    class_name: :Track,
    dependent: :destroy
  )
end
