require "rails_helper"

RSpec.feature "User signup" do
  describe "sign up new user successfully" do
    before do
      visit "/profile/new"

      within ".new_user" do
        fill_in("user_first_name", with: "John")
        fill_in("user_last_name", with: "Kags")
        fill_in("user_password", with: "johnkags")
        fill_in("user_password_confirmation", with: "johnkags")
        fill_in("user_email", with: "john@kags.com")
        fill_in("user_username", with: "john_kagscom")

        click_button("Create my account")
      end
    end

    it { expect(page).to have_current_path("/profile/john_kagscom") }
    it { expect(page).to have_css(".flash-success") }
    it { expect(page).to have_content("Profile") }
    it { expect(page).to have_content("Logout") }
  end

  scenario "sign up new user with errors" do
    visit "/profile/new"

    within ".new_user" do
      fill_in("user_first_name", with: "John")
      fill_in("user_last_name", with: "Kags")
      fill_in("user_password", with: "johnkagz")
      fill_in("user_password_confirmation", with: "johnkags")
      fill_in("user_email", with: "john@kags.com")
      fill_in("user_username", with: "john_kagscom")

      click_button("Create my account")
    end

    expect(page).to have_current_path("/profile")
    expect(page).to have_css(".flash-error")
  end
end
