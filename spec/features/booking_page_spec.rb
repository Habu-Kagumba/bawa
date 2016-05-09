require "rails_helper"

RSpec.feature "BookingPages" do
  let(:airport_one) { Faker::Address.state }
  let(:airport_two) { Faker::Address.city }

  subject(:booking) do
    create(:airport)
    create(:airport, name: airport_one, location: airport_two)
    create(:flight)
    create(:booking)

    visit root_path
  end

  scenario "Choose flight" do
    booking
    search_for_flight

    click_button("Book Now", match: :first)

    expect(page).to have_content(attributes_for(:airport)[:name])
  end

  scenario "Make a booking" do
    booking
    search_for_flight

    click_button("Book Now", match: :first)

    make_passengers

    click_button("Create Booking")

    expect(page).to have_content("Booking was successfully created")
  end

  scenario "Test booking saving failure" do
    booking
    search_for_flight

    click_button("Book Now", match: :first)

    make_passengers("invalidemail")

    click_button("Create Booking")

    expect(page).to have_css(".field_with_errors")
  end
end
