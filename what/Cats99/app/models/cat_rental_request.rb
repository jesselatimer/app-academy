# == Schema Information
#
# Table name: cat_rental_requests
#
#  id         :integer          not null, primary key
#  cat_id     :integer          not null
#  start_date :date             not null
#  end_date   :date             not null
#  status     :string           default("PENDING")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class CatRentalRequest < ActiveRecord::Base
  validates :start_date, :end_date, :cat, :status, presence: true
  validate :no_overlapping_approved_requests

  belongs_to(
    :cat,
    class_name: :Cat,
    foreign_key: :cat_id,
    primary_key: :id
  )

  def approve!
    # fail
    transaction do
      puts "APPROVE!"
      self.status = "APPROVED"
      save!
      overlapping_pending_requests.each do |request|
        request.deny!
      end
    end
  end

  def deny!
    self.status = "DENIED"
    save!
  end

  def pending?
    status == "PENDING"
  end

  # private

  def overlapping_requests
    requested_dates = (start_date..end_date).to_a
    cat.rental_requests.select do |request|
      request.id != id && requested_dates.any? do |date|
        date.between?(request.start_date,request.end_date)
      end
    end
  end

  def overlapping_approved_requests
    overlapping_requests.select do |request|
      request.status == "APPROVED"
    end
  end

  def no_overlapping_approved_requests
    unless overlapping_approved_requests.empty?
      errors[:date] << "can't overlap an existing rental date"
    end
  end

  def overlapping_pending_requests
    overlapping = overlapping_requests.select do |request|
      request.status == "PENDING"
    end
  end


end
