class Passenger < ActiveRecord::Base
  belongs_to :booking

  validates :first_name, :last_name, :email,
            presence: true
  validates :email, email: true
end
