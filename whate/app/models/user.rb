# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  user_name       :string(255)      not null
#  password_digest :string(255)      not null
#  session_token   :string(255)      not null
#  created_at      :datetime
#  updated_at      :datetime
#

class User < ActiveRecord::Base
  validates :user_name, :password_digest, :session_token, presence: true
  validates :user_name, :session_token, uniqueness: true
  validates :password, length: { minimum: 6, allow_nil: true }

  before_validation :ensure_session_token
  attr_reader :password

  has_many(
    :cats,
    class_name: "Cat",
    foreign_key: :user_id,
    primary_key: :id
  )
  
  def self.find_by_credentials(user_name, password)
    user = User.find_by_user_name(user_name)

    user && user.is_password?(password) ? user : nil
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(password_digest).is_password?(password)
  end

  def ensure_session_token
    self.session_token ||= generate_session_token
  end

  def reset_session_token!
    self.session_token = generate_session_token
    self.save!
  end

  def generate_session_token
    SecureRandom.urlsafe_base64
  end

end
