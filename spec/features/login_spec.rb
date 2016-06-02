require "rails_helper"

RSpec.feature "Sessions" do
  let(:stubbed_user) { build(:user) }
  let(:user) { create(:user) }

  context "When a user logs in" do
    scenario "user is unable to login with wrong credentials" do
      login_user(stubbed_user)
      expect(page).to have_css(".error")
    end

    scenario "successful login" do
      login_user(user)
      expect(page).to have_css(".flash-success")
      expect(page).to have_content("Successfully logged in")
    end
  end

  context "When a user logs out" do
    before do
      login_user(user)
    end

    scenario "user is redirected to login page after logout" do
      logout_user
      expect(page.current_path).to be_eql login_path
    end
  end
end
