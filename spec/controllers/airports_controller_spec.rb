require "rails_helper"

RSpec.describe AirportsController, type: :controller do
  let(:json) { JSON.parse(response.body) }
  subject { create(:airport) }

  context "When I search for airports" do
    it "searches for existing airports" do
      get :index, q: subject[:name]

      expect(json["count"]).to eql 1
      expect(json["results"][0]["name"]).to eql subject[:name]
    end
  end
end
