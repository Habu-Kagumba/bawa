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
    search_for_flight
    expect(page).to have_content("1 result")
  end

  scenario "Choose a flight" do
    search_for_flight
    click_button("Book Now")

    expect(page.current_path).to eql new_booking_path
  end
end
