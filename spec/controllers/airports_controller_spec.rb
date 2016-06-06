require "rails_helper"

RSpec.describe AirportsController, type: :controller do
  let(:json) { JSON.parse(response.body) }
  subject { create(:airport) }

  describe "search" do
    context "when an airport matches search" do
      it "returns the airport that matches search" do
        get :index, q: subject[:name]

        expect(json["count"]).to eql 1
        expect(json["results"][0]["name"]).to eql subject[:name]
      end
    end

    context "when no airport matches search" do
      it "returns no results if no airport found" do
        get :index, q: Faker::Name.first_name

        expect(json["count"]).to eql 0
        expect(json["results"]).to be_blank
      end
    end
  end
end
