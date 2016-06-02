require "rails_helper"

RSpec.describe Airport, type: :model do
  subject { create(:airport) }

  describe "Airport model validations" do
    it "airport factory should be valid" do
      should be_valid
    end
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:location) }
  end

  context "When I search for airports" do
    it "gets the correct airport" do
      searched_location = Airport.search(subject.name).first.location
      expect(subject.location).to eql searched_location
    end
  end
end
