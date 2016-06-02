class BookingsController < ApplicationController
  before_action :logged_in_user, only: [:index]
  before_action :set_booking_flight, only: [:show, :edit, :update, :destroy]

  def index
    @bookings = Booking.all.where(user_id: current_user.id)
  end

  def show
  end

  def new
    @booking = services.new_booking(
      create_booking_params,
      current_user
    )
    params[:passengers].to_i.times { @booking.passengers.build }
    render :new, locals: { f: services.parse_params(params) }
  end

  def create
    @booking = services.new_booking(booking_params, current_user)
    if @booking.save
      successful_booking(@booking, "created")
    else
      render :new, locals: {
        f: services.parse_params(
          services.parse_query_string(params[:parameters])
        )
      }
    end
  end

  def manage
    @booking = Booking.find_by(booking_code: params[:booking_code].upcase)
    @booking ? (render json: @booking.as_json) : (render json: false)
  end

  def edit
  end

  def update
    if @booking.update(booking_params)
      successful_booking(@booking, "updated")
    else
      render :edit
    end
  end

  def destroy
    @booking.destroy
    flash[:success] = "Booking successfully destroyed."
    redirect_to bookings_url
  end

  private

  def set_booking_flight
    @booking = Booking.find(params[:id])
    @flight = FlightPresenter.new(Flight.find(@booking.flight_id))
  end

  def create_booking_params
    params.permit(:flight_id)
  end

  def booking_params
    params.require(:booking).permit(
      :flight_id,
      :user_id,
      :price,
      passengers_attributes: [
        :id,
        :first_name,
        :last_name,
        :email,
        :_destroy
      ]
    )
  end

  def services(booking = nil)
    BookingsServices.new(booking)
  end

  def successful_booking(booking, msg)
    services(booking).booking_email(current_user)
    flash[:success] = "Booking successfully #{msg}."
    redirect_to booking
  end
end
