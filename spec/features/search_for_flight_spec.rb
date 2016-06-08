require "rails_helper"

RSpec.feature "FlightSearch" do
  let(:flight) { create(:flight) }
  before do
    allow(Flight).to receive(:find).with(flight.id).and_return(flight)
  end

  context "When I search for a flight" do
    before do
      visit root_path
    end

    scenario "I see the search form" do
      expect(page).to have_selector("form#search-flights")
    end

    scenario "I see flight suggestions" do
      search_for_flight(flight.departure_location)
      expect(page).to have_content("1 result")
    end

    scenario "I choose a flight" do
      search_for_flight(flight.departure_location)
      click_button("Book Now", match: :first)
      expect(page.current_path).to be_eql new_booking_path
    end
  end
end
