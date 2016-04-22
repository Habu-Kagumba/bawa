require "rails_helper"

RSpec.describe UsersHelper, type: :helper do
  describe "Full name" do
    subject { create(:user) }
    it "Builds a user full name" do
      expect(helper.name(attributes_for(:user))).to eq "Herbert Kagumba"
    end
  end
end
