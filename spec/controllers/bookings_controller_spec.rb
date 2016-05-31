require "rails_helper"

RSpec.describe BookingsController, type: :controller do
  let(:user) { create(:user) }
  let(:flight) { create(:flight) }
  let(:booking) do
    build(:booking, flight_id: flight.id)
  end
  let(:other_booking) do
    build_stubbed(:booking, flight_id: flight.id)
  end
  let(:user_booking) do
    create(:booking, user_id: user.id, flight_id: flight.id)
  end
  let(:valid_attributes) { attributes_for(:booking) }
  let(:invalid_attributes) { attributes_for(:invalid_booking) }

  shared_examples "access to all bookings" do
    describe "GET #index" do
      before :each do
        get :index
      end

      it "returns an array of bookings" do
        expect(assigns(:bookings)).to match_array [user_booking]
      end

      it "renders the index view" do
        expect(response).to render_template :index
      end
    end
  end

  shared_examples "no access to all bookings" do
    it "redirects anonymous user to login" do
      get :index
      expect(response).to redirect_to login_path
    end
  end

  shared_examples "access a booking" do
    describe "GET #show" do
      before :each do
        booking.save
        allow(Booking).to receive(:find).with(booking.slug).and_return(booking)
        get :show, id: booking
      end

      it "renders the show view" do
        expect(response).to render_template :show
      end

      it "returns the booking's flight" do
        expect(assigns("flight")).to eql flight
      end

      it "returns the stubbed booking" do
        expect(assigns(:booking)).to eql booking
      end

      it "decorates the flight with presenters" do
        presented_flight = FlightPresenter.new(flight)
        expect(presented_flight).to respond_to :adate
        expect(presented_flight).to respond_to :ddate
        expect(presented_flight).to respond_to :flight_price
        expect(presented_flight).to respond_to :departure_time
        expect(presented_flight).to respond_to :arrival_time
      end
    end
  end

  shared_examples "create new booking" do
    describe "GET #new" do
      before :each do
        get :new
      end

      it "renders the new template" do
        expect(response).to render_template(:new)
      end

      it "assigns a new Booking" do
        expect(assigns(:booking)).to be_a_new(Booking)
      end
    end

    describe "GET #edit" do
      before :each do
        booking.save
        get :edit, id: booking
      end

      it "assigns the requested booking" do
        expect(assigns(:booking)).to eql booking
      end

      it "renders the edit view" do
        expect(response).to render_template :edit
      end
    end

    describe "PUT #update" do
      context "use valid attributes" do
        it "updates correct booking" do
          booking.save
          allow(booking).to receive(:update).
            with(valid_attributes.stringify_keys) { true }
          put :update, id: booking, booking: valid_attributes
          expect(assigns(:booking)).to eq booking
        end

        it "redirects to the updated booking" do
          booking.save
          put :update, id: booking, booking: valid_attributes
          expect(response).to redirect_to booking
        end
      end

      context "use invalid attributes" do
        before :each do
          booking.save
          allow(booking).to receive(:update).
            with(invalid_attributes.stringify_keys) { false }
          put :update, id: booking, booking: invalid_attributes
        end

        it "renders the edit page" do
          expect(response).to render_template :edit
        end
      end
    end

    describe "POST #create" do
      context "use valid attributes" do
        before :each do
          post :create, booking: booking.attributes
        end

        it "creates a new booking" do
          expect(Booking.exists?(assigns(:booking).id)).to be true
        end

        it "redirects to newly created booking" do
          expect(response).to redirect_to Booking.last
        end
      end

      context "user invalid attributes" do
        before :each do
          post :create, booking: invalid_attributes
        end

        it "doesn't create new booking" do
          expect(Booking.exists?(booking.id)).to be false
        end

        it "renders the new page" do
          expect(response).to render_template :new
        end
      end
    end

    describe "DELETE #destroy" do
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

    describe "GET #manage" do
      before :each do
        booking.save
      end

      it "should return booking with matching booking_code" do
        get :manage, booking_code: booking.booking_code, format: "json"
        expect(assigns(:booking)).to eql booking
      end

      it "should return false if no booking is found" do
        get :manage, booking_code: other_booking.booking_code, format: "json"
        expect(response.body).to eql "false"
      end
    end
  end

  context "When a user visits the index view" do
    before do
      allow(controller).to receive(:current_user) { user }
    end
    it_behaves_like "access to all bookings"
  end

  context "When an anonymous user visits the index view" do
    it_behaves_like "no access to all bookings"
  end

  context "When I visit the booking pages" do
    it_behaves_like "access a booking"
    it_behaves_like "create new booking"
  end
end
