require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  subject(:user) { create(:user) }

  describe "User signup" do
    let(:mail) { UserMailer.welcome_email(user) }

    it "has the correct headers" do
      expect(mail.subject).to eq "Welcome to Bawa"
      expect(mail.to).to eq [user.email]
      expect(mail.from).to eq ["no-reply@bawa.com"]
    end
  end
end
