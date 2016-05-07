require "rails_helper"

RSpec.describe FlightsHelper, type: :helper do
  subject(:flight) do
    create(:airport)
    create(:airport, name: "TZX", location: "Dar El Salaam")
    create(:flight)
  end

  describe "Airline logo" do
    it "creates a random airline logo image" do
      img = helper.logo

      expect(img).to include("<img src=\"https://pigment.github.io")
    end
  end
end
