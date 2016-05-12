require "rails_helper"

RSpec.describe AirportsController, type: :controller do
  let(:json) { JSON.parse(response.body) }

  describe "Routes" do
    context "When I visit the airports page" do
      it do
        should route(:get, "airports").to("airports#index")
      end
    end
  end

  describe "Search" do
    before :each do
      @airport = create(:airport)
    end

    context "When I search for aiports" do
      it "should return 0 results for non-existent airport" do
        get :index, q: "non-existent-airport"

        should respond_with(200)

        expect(json["count"]).to be_zero
      end

      it "should return results for existing aiports" do
        get :index, q: @airport.name

        should respond_with(200)

        expect(json["count"]).to eql 1
        expect(json["results"][0]["name"]).to eql @airport.name
      end
    end
  end
end
