require "rails_helper"

RSpec.describe AirportController, type: :controller do
  let(:json) { JSON.parse(response.body) }

  before :all do
    create(:airport)
  end

  describe "Routes" do
    context "When I visit the airports page" do
      it do
        should route(:get, "airports").to("airport#index")
      end
    end
  end

  describe "Search" do
    context "When I search for aiports" do
      it "should return 0 results for non-existent airport" do
        get :index, q: "KLM"

        should respond_with(200)

        expect(json["count"]).to be_zero
      end

      it "should return results for existing aiports" do
        get :index, q: "JKIA"

        should respond_with(200)

        expect(json["count"]).to eql 1
      end
    end
  end
end
