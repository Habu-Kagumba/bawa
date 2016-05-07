require "rails_helper"

RSpec.describe Airport, type: :model do
  subject(:airport) do
    create(:airport)
  end

  describe "Validation" do
    context "when I create an airport" do
      it "should be valid" do
        expect(airport).to be_valid
      end
    end
  end

  describe "Searching" do
    context "when I search for airports" do
      it "get the correct result" do
        res = Airport.search("jkia")
        expect(airport.location).to eql res.first.location
      end
    end
  end
end
