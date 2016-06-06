require "rails_helper"

RSpec.feature "Updating bookings" do
  let(:user) { create(:user) }
  let(:airport) { create(:airport, id: 1) }
  let(:flight) { create(:flight) }
  let(:booking) { create(:booking, flight_id: flight.id, user_id: user.id) }
  before do
    airport && create(:airport, id: 2) && flight
    create(:passenger, booking_id: booking.id)
  end

  context "When I search for booking" do
    before do
      visit root_path
      search_for_booking(booking)
    end

    scenario "I can search for booking using the booking code" do
      expect(page).to have_content(booking.booking_code)
      expect(page).to have_content(flight.airline)
      expect(page).to have_content(airport.name)
    end

    scenario "I can update the booking" do
      update_booking
      expect(page).to have_content("Herbert")
    end
  end

  context "When I view past bookings as a user" do
    before do
      login_user(user)
      delete_booking
    end

    scenario "I see a list of past bookings" do
      expect(page).to have_content("View your bookings")
      expect(page).to have_content(flight.airline)
      expect(page).to have_content(airport.name)
    end

    scenario "I can delete a booking" do
      click_link("Cancel")
      expect(page).not_to have_content(flight.airline)
    end
  end
end
