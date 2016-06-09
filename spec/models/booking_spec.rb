require "rails_helper"

RSpec.describe Booking, type: :model do
  subject do
    create(:booking)
  end

  describe "Booking model validation" do
    it "booking factory should be valid" do
      should be_valid
    end
    it { should validate_presence_of(:flight_id) }
  end

  describe "Booking code" do
    it "creates a booking_code on save" do
      expect(subject.booking_code).not_to be_nil
    end
    it "should generate new slug if booking_code has changed" do
      original_slug = subject.slug
      subject.update(booking_code: Faker::Code.flight)
      expect(subject.slug).not_to eql original_slug
    end
  end
end
