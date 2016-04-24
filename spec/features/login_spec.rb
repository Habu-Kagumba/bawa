require "rails_helper"

RSpec.feature "Sessions" do
  describe "login with invalid information" do
    before do
      visit "/login"

      within ".form" do
        fill_in("session_email_username", with: "")
        fill_in("session_password", with: "")

        click_button("Log in")
      end
    end

    it { expect(page).to have_css(".flash-error") }
    it { expect(page).not_to have_content("Profile")  }
    it { expect(page).not_to have_content("Logout")  }
    it { expect(page).to have_content("Login")  }
    it { expect(page).to have_content("Sign in")  }
  end

  describe "login with valid information using username" do
    before do
      login_user_feature("username")
    end

    it { expect(page).to have_css(".flash-success") }
    it { expect(page).to have_content("Profile") }
    it { expect(page).to have_content("Logout") }
    it { expect(page).not_to have_content("Login")  }
    it { expect(page).not_to have_content("Sign in")  }
  end

  describe "login with valid information using email" do
    before do
      login_user_feature()
    end

    it { expect(page).to have_css(".flash-success") }
    it { expect(page).to have_content("Profile")  }
    it { expect(page).to have_content("Logout")  }
    it { expect(page).not_to have_content("Login")  }
    it { expect(page).not_to have_content("Sign in")  }
  end

  describe "login browser session" do
    before do
      login_user_feature()
    end

    it "creates session cookies" do
      session_cookies = get_me_the_cookie("user_id")
      expect(session_cookies).not_to be nil
      expect(page).to have_css(".flash-success")
      expect(page).to have_content("Profile")
      expect(page).to have_content("Logout")
      expect(page).not_to have_content("Login")
      expect(page).not_to have_content("Sign in")
    end

    it "deletes session cookies" do
      delete_cookie("remember_token")
      delete_cookie("user_id")
      delete_cookie("_bawa_session")
      expect(get_me_the_cookies.empty?).to be true

      visit '/'

      expect(page).not_to have_content("Profile")
      expect(page).not_to have_content("Logout")
      expect(page).to have_content("Login")
      expect(page).to have_content("Sign in")
    end
  end
end
