require "rails_helper"

RSpec.describe BookingMailer, type: :mailer do
  describe "Booking mail" do
    let(:user) { create(:user) }
    let(:booking) { create(:booking, user_id: user.id) }
    let(:mail) { BookingMailer.successful_booking(booking, user) }

    it "has the correct headers" do
      expect(mail.subject).to eq "Booking successful."
      expect(mail.to).to eq [user.email]
      expect(mail.from).to eq ["no-reply@bawa.com"]
    end
  end
end
