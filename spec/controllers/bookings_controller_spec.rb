require "rails_helper"

RSpec.describe BookingsController, type: :controller do
  let(:user) { create(:user) }
  let(:flight) { create(:flight) }
  let(:airport1) { create(:airport, id: 1) }
  let(:airport2) { create(:airport, id: 2) }
  let(:booking) do
    airport1 && airport2
    build(:booking, flight_id: flight.id)
  end
  let(:other_booking) do
    airport1 && airport2
    build_stubbed(:booking, flight_id: flight.id)
  end
  let(:user_booking) do
    create(:booking, user_id: user.id, flight_id: flight.id)
  end
  let(:valid_attributes) { attributes_for(:booking) }
  let(:invalid_attributes) { attributes_for(:invalid_booking) }

  describe "All bookings" do
    context "When a user views all bookings" do
      before do
        allow(controller).to receive(:current_user) { user }
        get :index
      end

      subject { assigns(:bookings) }

      it "shows all past bookings" do
        is_expected.to match_array [user_booking]
      end
    end

    context "When an anonymous user views all bookings" do
      before do
        get :index
      end

      it "redirects to the login page" do
        expect(response).to redirect_to login_path
      end
    end
  end

  describe "Show booking" do
    context "When I view a booking" do
      before do
        booking.save
        allow(Booking).to receive(:find).with(booking.slug).and_return(booking)
        get :show, id: booking
      end

      it "renders the show view" do
        expect(response).to render_template :show
      end

      subject(:show_flight) { assigns("flight") }
      subject(:show_booking) { assigns(:booking) }

      it "sets the flight and booking" do
        expect(show_flight).to eql flight
        expect(show_booking).to eql booking
      end

      subject(:presented_flight) { FlightPresenter.new(flight) }

      it "decorates the flight with presenters" do
        expect(presented_flight).to respond_to :adate
        expect(presented_flight).to respond_to :ddate
        expect(presented_flight).to respond_to :flight_price
        expect(presented_flight).to respond_to :departure_time
        expect(presented_flight).to respond_to :arrival_time
      end
    end
  end

  describe "New booking" do
    context "When I'm creating a new booking" do
      before do
        get :new
      end

      it "renders the new template" do
        expect(response).to render_template(:new)
      end

      subject(:new_booking) { assigns(:booking) }

      it "creates a new booking" do
        expect(new_booking).to be_a_new(Booking)
      end
    end
  end

  describe "Edit booking" do
    context "When I edit a booking" do
      before do
        booking.save
        get :edit, id: booking
      end

      subject(:edit_booking) { assigns(:booking) }

      it "retrieves the correct booking" do
        expect(edit_booking).to eql booking
      end

      it "renders the edit view" do
        expect(response).to render_template :edit
      end
    end
  end

  describe "Update booking" do
    context "When booking attributes are valid" do
      before :each do
        booking.save
        allow(booking).to receive(:update).
          with(valid_attributes.stringify_keys) { true }
        put :update, id: booking, booking: valid_attributes
      end

      subject(:update_booking) { assigns(:booking) }

      it "updates the correct booking" do
        expect(update_booking).to eq booking
      end

      it "redirects to the updated booking" do
        expect(response).to redirect_to booking
      end
    end

    context "When booking attributes are invalid" do
      before :each do
        booking.save
        allow(booking).to receive(:update).
          with(invalid_attributes.stringify_keys) { false }
        put :update, id: booking, booking: invalid_attributes
      end

      it "fails to update booking" do
        expect(response).to render_template :edit
      end
    end
  end

  describe "Create booking" do
    context "When booking attributes are valid" do
      before :each do
        post :create, booking: booking.attributes
      end

      subject(:create_booking) { assigns(:booking) }

      it "creates a new booking" do
        expect(Booking.exists?(create_booking.id)).to be true
      end

      it "redirects to newly created booking" do
        expect(response).to redirect_to Booking.last
      end
    end

    context "When booking attributes are invalid" do
      before :each do
        post :create, booking: invalid_attributes
      end

      it "doesn't manage bookings" do
        expect(Booking.exists?(booking.id)).to be false
      end

      it "renders the new page" do
        expect(response).to render_template :new
      end
    end
  end

  describe "Delete booking" do
    context "When a booking is deleted" do
      before :each do
        booking.save
        delete :destroy, id: booking
      end

      it "deletes a booking" do
        expect(Booking.exists?(booking.id)).to be false
      end

      it "redirects to bookings page" do
        expect(response).to redirect_to bookings_url
      end
    end
  end

  describe "Manage bookings" do
    context "When a booking is retrieved" do
      before :each do
        allow(controller).to receive(:current_user) { user }
        booking.save
      end

      subject(:manage_booking) { assigns(:booking) }

      it "should return booking with matching booking_code" do
        get :manage, booking_code: booking.booking_code, format: "json"
        expect(manage_booking).to eql booking
      end

      it "should return false if no booking is found" do
        get :manage, booking_code: other_booking.booking_code, format: "json"
        expect(response.body).to eql "false"
      end
    end
  end
end
