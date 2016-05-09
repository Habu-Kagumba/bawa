module FeatureHelpers
  def login_as(user)
    @request.session[:user_id] = user.id
  end

  def login_user_feature(user_email = "email")
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

  def search_for_flight
    within ".form" do
      fill_in("location_name", with: "Dar El Salaam")
      fill_in("destination_name", with: "Nairobi")
      fill_in("when", with: "26/04/2016")
      fill_in("passengers", with: "2")

      click_button("Search flights")
    end
  end

  def make_passengers(email = Faker::Internet.email)
    fname = Faker::Name.first_name
    lname = Faker::Name.last_name
    fname2 = Faker::Name.first_name
    lname2 = Faker::Name.last_name
    email2 = Faker::Internet.email

    fill_in("booking_passengers_attributes_0_first_name",
            with: fname)
    fill_in("booking_passengers_attributes_0_last_name",
            with: lname)
    fill_in("booking_passengers_attributes_0_email",
            with: email)

    fill_in("booking_passengers_attributes_1_first_name",
            with: fname2)
    fill_in("booking_passengers_attributes_1_last_name",
            with: lname2)
    fill_in("booking_passengers_attributes_1_email",
            with: email2)
  end
end
