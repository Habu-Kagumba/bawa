require "rails_helper"

RSpec.describe Booking, type: :model do
  let(:flight) { create(:flight) }
  subject do
    create(:booking, flight_id: flight.id)
  end

  context "booking model validation" do
    it "booking factory should be valid" do
      should be_valid
    end
    it { should validate_presence_of(:flight_id) }
  end

  context "Booking models id" do
    it "creates a booking_code on save" do
      expect(subject.booking_code).not_to be_nil
    end
    it "should generate new slug if booking_code has changed" do
      original_slug = subject.slug
      subject.update(booking_code: Faker::Code.flight)
      expect(original_slug).not_to eql subject.slug
    end
  end
end
