require "rails_helper"

RSpec.feature do
  let(:user) { create(:user) }
  let(:flight) { create(:flight) }

  before do
    allow(Flight).to receive(:find).with(flight.id).and_return(flight)
  end

  context "When I book a flight anonymously" do
    before do
      visit root_path
      search_for_flight(flight.departure_location)
      click_button("Book Now", match: :first)
    end

    scenario "I am in the booking page" do
      expect(page).to have_content("Book your flight")
    end

    scenario "The correct price is displayed" do
      expect(page).to have_content(flight.price * 2)
    end

    scenario "I add passengers and make booking" do
      email = Faker::Internet.safe_email
      make_passengers(email)
      click_button("Create Booking")
      expect(page).to have_content("Booking successfully created.")
      expect(page).to have_content(flight.airline)
      expect(page).to have_content(email)
    end
  end

  context "When I book a flight as a user" do
    before do
      login_user(user)
      visit root_path
      search_for_flight(flight.departure_location)
      click_button("Book Now", match: :first)
    end

    scenario "I am in the booking page" do
      expect(page).to have_content("Book your flight")
    end

    scenario "The correct price is displayed" do
      expect(page).to have_content(flight.price * 2)
    end

    scenario "I add passengers and make booking" do
      email = Faker::Internet.safe_email
      make_passengers(email)
      click_button("Create Booking")
      expect(page).to have_content("Booking successfully created.")
      expect(page).to have_content(flight.airline)
      expect(page).to have_content(email)
    end
  end
end
