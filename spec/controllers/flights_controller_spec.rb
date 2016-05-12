require "rails_helper"

RSpec.describe FlightsController, type: :controller do
  let(:json) { JSON.parse(response.body) }

  before :all do
    create(:airport)
    create(:airport, name: "TZX", location: "Dar El Salaam")
    create(:flight)
  end

  describe "Routes" do
    context "When I search for flights" do
      it do
        should route(:get, search_flight_path).to("flights#search_flights")
      end
    end
  end

  describe "Search" do
    context "When I search for flights" do
      it "should return 0 results for non-existent flights" do
        get :search_flights, format: :json,
                             when: "10/10/1990"

        should respond_with(200)

        expect(json["count"]).to be_zero
      end

      it "should return results for existing flights" do
        get :search_flights, format: :json,
                             when: attributes_for(:flight)[:departure_date]

        should respond_with(200)

        expect(json["count"]).not_to be be_zero
      end
    end
  end
end