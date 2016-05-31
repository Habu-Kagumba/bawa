class BookingsServices
  def initialize(booking = nil)
    @booking = booking
  end

  def new_booking(parameters, current_user = nil)
    booking = Booking.new(parameters)
    booking.user_id = current_user.id if current_user
    booking
  end

  def booking_email(user)
    if user
      BookingMailer.successful_booking(@booking, user).deliver_later
    else
      @booking.passengers.map do |passenger|
        BookingMailer.successful_booking(@booking, passenger).deliver_later
      end
    end
  end

  def parse_query_string(parameters)
    Rack::Utils.parse_nested_query(parameters)
  end

  def parse_params(obj)
    result = {}
    obj.map { |k, v| result[k] = v }
    result
  end
end
