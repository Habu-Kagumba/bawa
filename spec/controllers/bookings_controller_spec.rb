require "rails_helper"

RSpec.describe BookingsController, type: :controller do
  let(:booking) { create(:booking) }
  let(:user_booking) { create(:user_booking) }
  let(:valid_attributes) { attributes_for(:booking) }
  let(:invalid_attributes) do
    { flight_id: nil }
  end

  describe "All bookings" do
    context "When a user views all bookings" do
      before do
        allow(controller).to receive(:current_user) { user_booking.user }
      end

      subject { assigns(:bookings) }

      it "shows all past bookings" do
        get :index
        is_expected.to match_array [user_booking]
      end
    end

    context "When an anonymous user views all bookings" do
      it "redirects to the login page" do
        get :index
        expect(response).to redirect_to login_path
      end
    end
  end

  describe "Show booking" do
    context "When I view a booking" do
      before do
        allow(Booking).to receive(:find).with(booking.slug).and_return(booking)
      end

      it "renders the show view" do
        get :show, id: booking
        expect(response).to render_template :show
      end

      it "sets the booking" do
        get :show, id: booking
        expect(assigns(:booking)).to eql booking
        expect(assigns(:flight)).to eql booking.flight
      end

      let(:presented_flight) { FlightPresenter.new(booking.flight) }

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
      it "renders the new template" do
        get :new
        expect(response).to render_template(:new)
      end

      subject { assigns(:booking) }

      it "creates a new booking" do
        get :new
        is_expected.to be_a_new(Booking)
      end
    end
  end

  describe "Edit booking" do
    context "When I edit a booking" do
      subject { assigns(:booking) }

      it "retrieves the correct booking" do
        get :edit, id: booking
        is_expected.to eql booking
      end

      it "renders the edit view" do
        get :edit, id: booking
        expect(response).to render_template :edit
      end
    end
  end

  describe "Update booking" do
    context "When booking attributes are valid" do
      before do
        allow(booking).to receive(:update).
          with(valid_attributes.stringify_keys) { true }
      end

      subject { assigns(:booking) }

      it "updates the correct booking" do
        put :update, id: booking, booking: valid_attributes
        is_expected.to eq booking
      end

      it "redirects to the updated booking" do
        put :update, id: booking, booking: valid_attributes
        expect(response).to redirect_to booking
      end
    end

    context "When booking attributes are invalid" do
      before do
        allow(booking).to receive(:update).
          with(invalid_attributes) { false }
      end

      it "fails to update booking" do
        put :update, id: booking, booking: invalid_attributes
        expect(response).to render_template :edit
      end
    end
  end

  describe "Create booking" do
    context "When booking attributes are valid" do
      let(:ze_booking) { assigns(:booking) }

      it "creates a new booking" do
        post :create, booking: booking.attributes
        expect(Booking.where(id: ze_booking.id)).to exist
      end

      it "redirects to newly created booking" do
        post :create, booking: booking.attributes
        expect(response).to redirect_to Booking.last
      end
    end

    context "When booking attributes are invalid" do
      it "doesn't manage bookings" do
        post :create, booking: invalid_attributes
        expect(Booking.where(id: booking.id)).to exist
      end

      it "renders the new page" do
        post :create, booking: invalid_attributes
        expect(response).to render_template :new
      end
    end
  end

  describe "Delete booking" do
    context "When a booking is deleted" do
      it "deletes a booking" do
        delete :destroy, id: booking
        expect(Booking.where(id: booking.id)).not_to exist
      end

      it "redirects to bookings page" do
        delete :destroy, id: booking
        expect(response).to redirect_to bookings_url
      end
    end
  end

  describe "Manage bookings" do
    context "When a booking is retrieved" do
      before do
        allow(controller).to receive(:current_user) { user_booking.user }
      end

      subject { assigns(:booking) }

      it "should return booking with matching booking_code" do
        get :manage, booking_code: booking.booking_code, format: "json"
        is_expected.to eql booking
      end

      it "should return false if no booking is found" do
        get :manage, booking_code: Faker::Code.flight, format: "json"
        expect(response.body).to eql "false"
      end
    end
  end
end
