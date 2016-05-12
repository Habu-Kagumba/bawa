require "rails_helper"

RSpec.feature "BookingPages" do
  before :each do
    login_user_feature
    @airport = create(:airport, id: 1)
    @aiport2 = create(:airport, id: 2)
    @flight = create(:flight,
                     departure_location_id: @airport.id,
                     arrival_location_id: @aiport2.id)
    visit root_path
    search_for_flight
    click_button("Book Now", match: :first)
  end

  scenario "Choose flight" do
    expect(page).to have_content("Book your flight")
  end

  scenario "Make a booking" do
    make_passengers
    click_button("Create Booking")
    expect(page).to have_content("Booking was successfully created")
  end

  scenario "Test booking saving failure" do
    make_passengers("invalidemail")
    click_button("Create Booking")
    expect(page).to have_css(".field_with_errors")
  end
end
