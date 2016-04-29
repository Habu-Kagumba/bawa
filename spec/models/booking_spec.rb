require "rails_helper"

RSpec.describe Booking, type: :model do
  subject(:booking) do
    create(:flight)
    create(:booking)
  end

  describe "Validation" do
    context "when I create a booking" do
      it "should be valid" do
        expect(booking).to be_valid
      end
    end
  end

  describe "Get the price and booking reference" do
    context "when I get the price of a booking" do
      it "has a price" do
        expect(booking.price).not_to be_blank
      end
    end

    context "when I get the booking reference number" do
      it "has a booking reference" do
        expect(booking.booking_id).not_to be_blank
      end
    end
  end
end
