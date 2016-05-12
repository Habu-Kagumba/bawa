require "rails_helper"

RSpec.feature "User signup" do
  let(:user) { build_stubbed(:user) }
  let(:user2) { build_stubbed(:user) }

  describe "sign up new user successfully" do
    before do
      visit "/profile/new"

      within ".user-forms" do
        fill_in("user_first_name", with: user.first_name)
        fill_in("user_last_name", with: user.last_name)
        fill_in("user_password", with: user.password)
        fill_in("user_password_confirmation", with: user.password)
        fill_in("user_email", with: user.email)
        fill_in("user_username", with: user.username)

        click_button("Create my account")
      end
    end

    it { expect(page).to have_css(".flash-success") }
    it { expect(page).to have_content("Past bookings") }
    it { expect(page).to have_content("Logout") }
  end

  scenario "sign up new user with errors" do
    visit "/profile/new"

    within ".user-forms" do
      fill_in("user_first_name", with: user2.first_name)
      fill_in("user_last_name", with: user2.last_name)
      fill_in("user_password", with: user2.password)
      fill_in("user_password_confirmation", with: user2.password)
      fill_in("user_email", with: user2.email)
      fill_in("user_username", with: "john_kagscom.0")

      click_button("Create my account")
    end

    expect(page).to have_css(".flash-error")
  end

  scenario "sign up new user with errors - test js validation" do
    @user = create(:user)

    visit "/profile/new"

    within ".user-forms" do
      fill_in("user_first_name", with: @user.first_name)
      fill_in("user_last_name", with: @user.last_name)
      fill_in("user_password", with: @user.password)
      fill_in("user_password_confirmation", with: @user.password)
      fill_in("user_email", with: @user.email)
      fill_in("user_username", with: @user.username)

      click_button("Create my account")
    end

    expect(page).to have_css(".error")
  end
end
