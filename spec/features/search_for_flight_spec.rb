require "rails_helper"

RSpec.feature "FlightSearch" do
  let(:airport) { create(:airport, id: 1) }
  let(:flight) { create(:flight) }
  before do
    airport && create(:airport, id: 2) && flight
  end

  context "When I search for a flight" do
    before do
      visit root_path
    end

    scenario "I see the search form" do
      expect(page).to have_selector("form#search-flights")
    end

    scenario "I see flight suggestions" do
      search_for_flight(airport)
      expect(page).to have_content("1 result")
    end

    scenario "I choose a flight" do
      search_for_flight(airport)
      click_button("Book Now", match: :first)
      expect(page.current_path).to be_eql new_booking_path
    end
  end
end
