require "rails_helper"

RSpec.feature "ProfilePage" do
  before :each do
    create(:user)
  end

  scenario "Visit profile page." do
    visit user_path(attributes_for(:user)[:username])

    within "div.user-content" do
      expect(page).to have_selector(
        "h1", text: "Welcome #{attributes_for(:user)[:first_name]} #{attributes_for(:user)[:last_name]}"
      )
    end
  end
end
