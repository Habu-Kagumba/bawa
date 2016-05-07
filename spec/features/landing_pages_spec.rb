require "rails_helper"

RSpec.feature "LandingPages" do
  before do
    create(:airport)
    create(:airport, name: "TZX", location: "Dar El Salaam")
    create(:flight)

    visit root_path
  end

  scenario "Landing page elements." do
    expect(page).to have_selector(
      "h1", text: "Bawa Secure and reliable flight booking."
    )
    expect(page).to have_link("Sign up")
    expect(page).to have_link("Login")
    expect(page).to have_selector("form#search-flights")
  end

  scenario "Search for flights" do
    within ".form" do
      fill_in("location_name", with: "Dar El Salaam")
      fill_in("destination_name", with: "Nairobi")
      fill_in("when", with: "26/04/2016")
      fill_in("passengers", with: "2")

      click_button("Search flights")
    end

    expect(page).to have_content("1 result")
  end
end
