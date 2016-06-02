require "rails_helper"

RSpec.describe BookingMailer, type: :mailer do
  describe "Booking mail" do
    before do
      create(:airport, id: 1)
      create(:airport, id: 2)
    end
    let(:user) { create(:user) }
    let(:flight) { create(:flight) }
    let(:booking) { create(:booking, flight_id: flight.id) }
    let(:mail) { BookingMailer.successful_booking(booking, user) }

    it "has the correct headers" do
      expect(mail.subject).to eq "Booking successful."
      expect(mail.to).to eq [user.email]
      expect(mail.from).to eq ["no-reply@bawa.com"]
    end
  end
end
