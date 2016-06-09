require "rails_helper"

RSpec.describe Flight, type: :model do
  subject do
    create(:flight)
  end

  describe "flight model validation" do
    it "flight factory should be valid" do
      should be_valid
    end
    it { should validate_presence_of(:departure_location_id) }
    it { should validate_presence_of(:arrival_location_id) }
    it { should validate_presence_of(:flight_number) }
    it { should validate_presence_of(:airline) }
    it { should validate_presence_of(:departure_date) }
    it { should validate_presence_of(:arrival_date) }
  end

  describe "flight model associations" do
    it { should have_many(:bookings) }
  end

  describe "flight model scopes and filter for searching" do
    it "can search flight by the location" do
      expect(Flight.location(subject.departure_location_id)).
        to include(subject)
    end
    it "can search flight by the destination" do
      expect(Flight.destination(subject.arrival_location_id)).
        to include(subject)
    end
    it "can search flight by the departure date" do
      expect(
        Flight.when(subject.departure_date.to_s)
      ).to include(subject)
    end
    it "can search for flight using #filter" do
      expect(
        Flight.filter(
          location: subject.departure_location_id,
          destination: subject.arrival_location_id,
          when: subject.departure_date.to_s
        )
      ).to include(subject)
    end
  end
end
