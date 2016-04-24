module FeatureHelpers
  def login_as(user)
    @request.session[:user_id] = user.id
  end

  def login_user_feature(user_email="email")
    create(:user)

    visit "/login"

    within ".form" do
      fill_in("session_email_username",
              with: attributes_for(:user)[user_email.to_sym])
      fill_in("session_password", with: attributes_for(:user)[:password])
      check("Remember me")

      click_button("Log in")
    end
  end

  def update_profile(username)
    click_link "Profile settings"

    within ".user-edit-forms" do
      fill_in("user_username", with: username)

      click_button("Save changes")
    end
  end
end
