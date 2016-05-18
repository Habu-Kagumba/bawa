class BookingMailer < ApplicationMailer
  default from: "no-reply@bawa.com"

  def successful_booking(booking, user)
    @booking = booking
    @user = user
    @flights = FlightPresenter.new(@booking.flight)
    @url = URI.join("https://bawa.herokuapp.com/bookings/", @booking.slug)
    mail(to: @user.email, subject: "Booking successful.")
  end
end
