require "rails_helper"

RSpec.describe Passenger, type: :model do
  let(:flight) { create(:flight) }
  subject do
    create(:booking, flight_id: flight.id)
    create(:passenger)
  end

  context "passenger model validation" do
    it "passenger factory should be valid" do
      should be_valid
    end
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:email) }
  end

  context "passenger model associations" do
    it { should belong_to(:booking) }
  end
end
