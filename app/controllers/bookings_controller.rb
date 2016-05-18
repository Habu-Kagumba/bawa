class BookingsController < ApplicationController
  before_action :logged_in_user, only: [:index]
  before_action :set_booking_flight, only: [:show, :edit, :update, :destroy]

  def index
    @bookings = Booking.all.where(user_id: current_user.id)
  end

  def show
    flight = Flight.find(@booking.flight_id)
    @flight = FlightPresenter.new(flight)
  end

  def new
    @booking = Booking.new(create_booking_params)
    @booking.user_id = current_user.id if current_user
    locals = parse_params(params)
    params[:passengers].to_i.times { @booking.passengers.build }
    render :new, locals: { f: locals }
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.user_id = current_user.id if current_user
    locals = parse_params(parse_query_string(params[:parameters]))
    respond_to do |format|
      if @booking.save
        send_booking_email(@booking, current_user)
        format.html do
          redirect_to @booking, notice: "Booking was successfully created."
        end
      else
        format.html { render :new, locals: locals }
      end
    end
  end

  def manage
    @booking = Booking.find_by(booking_id: params[:booking_id].upcase)
    respond_to do |format|
      if @booking
        format.json { render json: @booking.as_json }
      else
        format.json { render json: false }
      end
    end
  end

  def edit
  end

  def update
    if @booking.update(booking_params)
      send_booking_email(@booking, current_user)
      redirect_to @booking, notice: "Booking was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @booking.destroy
    respond_to do |format|
      format.html do
        redirect_to bookings_url, notice: "Booking successfully destroyed."
      end
    end
  end

  private

  def set_booking_flight
    @booking = Booking.find(params[:id])
    @flight = Flight.find(@booking.flight_id)
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

  def parse_query_string(parameters)
    Rack::Utils.parse_nested_query(parameters)
  end

  def parse_params(obj)
    result = {}
    obj.map do |k, v|
      result[k] = v
    end
    result
  end

  def send_booking_email(booking, user)
    if logged_in?
      BookingMailer.successful_booking(booking, user).deliver_later
    else
      booking.passengers.map do |passenger|
        BookingMailer.successful_booking(booking, passenger).deliver_later
      end
    end
  end
end
