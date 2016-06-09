require "rails_helper"

RSpec.feature "Updating bookings" do
  let(:user) { create(:user) }
  let(:booking) { create(:booking, user_id: user.id) }

  before do
    allow(Booking).to receive(:find).with(booking.slug).and_return(booking)
    create(:passenger, booking_id: booking.id)
  end

  context "When I search for booking" do
    before do
      visit root_path
      find("span", text: "Manage Bookings").trigger("click")
      within "#manage-bookings-form" do
        fill_in("booking_code", with: booking.booking_code)
        click_button("Search Booking")
      end
    end

    scenario "I can search for booking using the booking code" do
      expect(page).to have_content(booking.booking_code)
      expect(page).to have_content(booking.flight.airline)
    end

    # scenario "I can update the booking" do
    #   visit edit_booking_path booking
    #   fill_in("booking_passengers_attributes_0_first_name",
    #           with: "Herbert")
    #   click_button "Update Booking"
    #   expect(page).to have_content("Herbert")
    # end
  end

  context "When I view past bookings as a user" do
    before do
      login_user(user)
      find("a", text: "Past bookings").trigger("click")
    end

    scenario "I see a list of past bookings" do
      expect(page).to have_content("View your bookings")
      expect(page).to have_content(booking.flight.airline)
    end

    scenario "I can delete a booking" do
      click_link("Cancel")
      expect(page).not_to have_content(booking.flight.airline)
    end
  end
end
