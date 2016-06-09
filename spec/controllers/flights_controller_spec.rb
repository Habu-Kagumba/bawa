require "rails_helper"

RSpec.describe FlightsController, type: :controller do
  let(:json) { JSON.parse(response.body) }
  let(:flight) { create(:flight) }

  describe "Searching flights" do
    context "When I search for a flight" do
      before do
        allow(Flight).to receive(:find).with(flight.id).and_return(flight)
      end

      it "should return all flights if no criteria is provided" do
        get :search_flights, format: :json, passengers: 3
        expect(json["count"]).to eql Flight.count
        expect(assigns[:result][:results]).to include flight
      end

      it "should return searched flight" do
        get :search_flights,
            format: :json,
            passengers: 3,
            when: flight.departure_date.strftime("%d/%m/%Y")
        expect(Flight.exists?(assigns[:result][:results].first)).to be true
      end
    end
  end
end
