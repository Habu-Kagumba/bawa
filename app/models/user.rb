class User < ActiveRecord::Base
  extend FriendlyId
  friendly_id :username, use: :slugged

  before_save do
    self.email = email.downcase
    self.first_name = first_name.capitalize
    self.last_name = last_name.capitalize
  end

  LETTERS_ONLY = /\A[a-zA-Z]+\z/
  USERNAME_REGEX = /\A[a-zA-Z0-9_]+\z/

  validates :first_name,
            presence: true,
            length: { in: 3..25 },
            format: { with: LETTERS_ONLY }

  validates :last_name,
            presence: true,
            length: { in: 3..25 },
            format: { with: LETTERS_ONLY }

  validates :username,
            presence: true,
            length: { in: 3..60 },
            uniqueness: { case_sensitive: false },
            format: { with: USERNAME_REGEX }

  validates :email,
            uniqueness: { case_sensitive: false },
            presence: true,
            email: true

  validates :password,
            confirmation: true,
            length: { in: 8..20 }

  validates :password_confirmation, presence: true

  has_secure_password
end
