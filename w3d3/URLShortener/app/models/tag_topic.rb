# == Schema Information
#
# Table name: tag_topics
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class TagTopic < ActiveRecord::Base

  validates :name, presence: true, uniqueness: true

  has_many(
    :taggings,
    foreign_key: :tag_topic_id,
    primary_key: :id,
    class_name: :Tagging
  )

  has_many(
    :shortened_urls,
    through: :taggings,
    source: :shortened_url
  )
end
