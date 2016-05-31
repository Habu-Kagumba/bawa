class User < ActiveRecord::Base
  attr_accessor :remember_token

  has_many :bookings

  extend FriendlyId
  friendly_id :username, use: :slugged

  before_save do
    self.email = email.downcase
    self.first_name = first_name.capitalize
    self.last_name = last_name.capitalize
  end

  validates :first_name,
            presence: true,
            length: { in: 3..25 },
            format: { with: Constants.LETTERS_REGEX }

  validates :last_name,
            presence: true,
            length: { in: 3..25 },
            format: { with: Constants.LETTERS_REGEX }

  validates :username,
            presence: true,
            length: { in: 3..60 },
            uniqueness: { case_sensitive: false },
            format: { with: Constants.USERNAME_REGEX }

  validates :email,
            uniqueness: { case_sensitive: false },
            presence: true,
            email: true

  validates :password,
            presence: true,
            length: { in: 8..20 },
            allow_nil: true

  has_secure_password
end
