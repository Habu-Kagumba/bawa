class User < ActiveRecord::Base
  attr_accessor:remember_token

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
            presence: true,
            length: { in: 8..20 },
            allow_nil: true

  has_secure_password

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  class << self
    # http://bit.ly/1pusLFu
    def digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? mcost : BCrypt::Engine.cost

      BCrypt::Password.create(string, cost: cost)
    end

    def mcost
      BCrypt::Engine::MIN_COST
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end
end
