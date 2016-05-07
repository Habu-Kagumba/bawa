require "rails_helper"

RSpec.describe UsersHelper, type: :helper do
  subject { create(:user) }

  describe "Full name" do
    it "Builds a user full name" do
      expect(helper.name(attributes_for(:user))).to eq "Herbert Kagumba"
    end
  end
end
