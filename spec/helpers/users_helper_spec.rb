require "rails_helper"

RSpec.describe UsersHelper, type: :helper do
  let(:user) { create(:user) }

  describe "Full name" do
    it "Builds a user full name" do
      expect(helper.name(user)).to eq "#{user.first_name} "\
        "#{user.last_name}"
    end
  end
end
