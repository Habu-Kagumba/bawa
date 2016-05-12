class BookingMailer < ApplicationMailer
  default from: "no-reply@bawa.com"

  def successful_booking(booking, user, locals)
    @booking = booking
    @user = user
    @flights = locals
    @url = URI.join("https://bawa.herokuapp.com/bookings/", @booking.slug)
    mail(to: @user.email, subject: "Booking successful.")
  end
end
