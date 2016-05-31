require "rails_helper"

RSpec.describe FlightsHelper, type: :helper do
  subject(:flight) do
    2.times { create(:airport) }
    create(:flight, departure_date: Date.yesterday)
  end

  describe "Airline logo" do
    it "creates a random airline logo image" do
      img = helper.logo

      expect(img).to include("<img src=\"https://pigment.github.io")
    end
  end

  describe "Expired flight" do
    it "Indicates if flight departure date has passed" do
      expect(helper.flight_expired(flight.departure_date)).to be_eql false
    end
  end
end
