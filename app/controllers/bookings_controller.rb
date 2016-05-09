class BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :edit, :update, :destroy]

  def index
    @bookings = Booking.all
  end

  def show
    flight = Flight.find(@booking.flight_id)
    @flight = FlightPresenter.new(flight)

    render :show
  end

  def new
    @booking = Booking.new(create_booking_params)
    @booking.user_id = current_user.id if current_user

    locals = {
      flight_id: params[:flight_id],
      airline: params[:airline],
      airline_logo: params[:airline_logo],
      flight_number: params[:flight_number],
      dtime: params[:dtime],
      ddate: params[:ddate],
      dname: params[:dname],
      dlocation: params[:dlocation],
      atime: params[:atime],
      adate: params[:adate],
      aname: params[:aname],
      alocation: params[:alocation],
      price: params[:price],
      passengers: params[:passengers]
    }

    params[:passengers].to_i.times { @booking.passengers.build }

    render :new, locals: locals
  end

  def edit
  end

  def create
    @booking = Booking.new(booking_params)

    respond_to do |format|
      if @booking.save
        format.html { redirect_to @booking, notice: 'Booking was successfully created.' }
        format.json { render :show, status: :created, location: @booking }
      else
        format.html { render :new }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @booking.update(booking_params)
        format.html { redirect_to @booking, notice: 'Booking was successfully updated.' }
        format.json { render :show, status: :ok, location: @booking }
      else
        format.html { render :edit }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @booking.destroy
    respond_to do |format|
      format.html { redirect_to bookings_url, notice: 'Booking was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_booking
      @booking = Booking.find(params[:id])
    end

    def create_booking_params
      params.permit(:flight_id)
    end

    def booking_params
      params.require(:booking).permit(:flight_id, :user_id, :price,
                                      passengers_attributes: [
                                        :id, :first_name, :last_name,
                                        :email,:_destroy])
    end
end
