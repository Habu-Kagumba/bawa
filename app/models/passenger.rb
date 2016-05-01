class Passenger < ActiveRecord::Base
  belongs_to :booking

  validates :first_name, :last_name,
            presence: true
  validates :email,
            presence: true, email: true
end
