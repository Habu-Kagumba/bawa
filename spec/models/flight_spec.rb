require "rails_helper"

RSpec.describe Flight, type: :model do
  subject(:flight) do
    create(:airport)
    create(:airport, name: "TZX", location: "Dar El Salaam")
    create(:flight)
  end

  describe "Validation" do
    context "when I create a flight" do
      it "should be valid" do
        expect(flight).to be_valid
      end
    end
  end

  describe "Get the price" do
    context "when I get the price of the flight" do
      it "has a price" do
        expect(flight.price).not_to be_blank
      end
    end
  end

  describe "Search flights" do
    context "when I search for flights using airport" do
      it "using 'location airport' matches using the airport" do
        expect(flight.airline).to eq Flight.filter(location: 2).first.airline
      end
    end

    context "when I search for flights using airport" do
      it "using 'destination airport' matches using the airport" do
        expect(flight.airline).to eq Flight.filter(destination: 1).first.airline
      end
    end

    context "when I search for flights using airport" do
      it "using 'departure date' matches using the airport" do
        expect(flight.airline).to eq Flight.
          filter(when: "2016-04-26 19:40").first.airline
      end
    end

    context "when I search for flights" do
      it "returns an array of matched results" do
        datums = [
          {
            when: "2016-04-26",
            location: 2,
            destination: 1
          }
        ]

        expect(flight).to be_eql Flight.filter(datums).first
      end
    end
  end
end
