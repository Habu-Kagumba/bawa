require "rails_helper"

RSpec.feature "ProfilePage" do
  before :each do
    login_user_feature("email")
  end

  describe "Visit profile page." do
    it do
      expect(page).to have_selector(
        "h1", text: "Welcome #{attributes_for(:user)[:first_name]}"\
        " #{attributes_for(:user)[:last_name]}"
      )
    end
    it { expect(page).to have_link("Home") }
    it { expect(page).to have_link("Profile settings") }
    it { expect(page).to have_link("Past bookings") }
    it { expect(page).to have_link("Logout") }
  end

  describe "Update profile" do
    it do
      update_profile("habu_reloaded")
      expect(page).to have_css(".flash-success")
    end
  end

  describe "Update profile failure" do
    it do
      update_profile("ro")
      expect(page).to have_css(".flash-error")
      expect(page).to have_current_path("/profile/habu")
    end
  end
end
