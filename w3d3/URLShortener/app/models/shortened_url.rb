# == Schema Information
#
# Table name: shortened_urls
#
#  id           :integer          not null, primary key
#  short_url    :string
#  long_url     :string
#  submitter_id :integer
#  created_at   :datetime
#  updated_at   :datetime
#

require 'uri'

class ShortenedUrl < ActiveRecord::Base
  validates :short_url, presence: true, uniqueness: true
  validates :long_url, presence: true, length: { maximum: 255 }
  validate :long_url_valid?
  validate :user_hasnt_submitted_in_excess

  belongs_to(
    :submitter,
    foreign_key: :submitter_id,
    primary_key: :id,
    class_name: :User
    )

  has_many(
    :visits,
    foreign_key: :shortened_url_id,
    primary_key: :id,
    class_name: :Visit
  )

  has_many(
    :visitors,
    through: :visits,
    source: :user
  )

  has_many(
    :distinct_visitors,
    -> { distinct },
    through: :visits,
    source: :user
  )

  has_many(
    :taggings,
    foreign_key: :shortened_url_id,
    primary_key: :id,
    class_name: :Tagging
  )

  has_many(
    :tag_topics,
    through: :taggings,
    source: :tag_topic
  )

  def self.random_code
    code = nil
    until code && !ShortenedUrl.exists?(code)
      code = SecureRandom.urlsafe_base64(16)
    end
    code
  end

  def self.create_for_user_and_long_url(user, long_url)
    ShortenedUrl.create!({
      long_url: long_url,
      short_url: ShortenedUrl.random_code,
      submitter_id: user.id
      })
  end

  def num_clicks
    self.visits.count
  end

  def num_uniques
    self.distinct_visitors.count
  end

  def num_recent_uniques
    visits = self.visits.where("updated_at > ?", 10.minutes.ago)
    visits.select(:user_id).distinct.count
  end

  private
  def long_url_valid?
    unless long_url =~ /\A#{URI::regexp}\z/
      errors[:long_url] << "not a valid url."
    end
  end

  def user_hasnt_submitted_in_excess
    unless User.find_by_id(submitter_id).num_recent_submissions < 5
      errors[:submitter_id] << "you have submitted in excess!"
    end
  end
end
