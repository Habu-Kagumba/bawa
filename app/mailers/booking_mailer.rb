class BookingMailer < ApplicationMailer
  default from: "no-reply@bawa.com"

  def successful_booking(booking, user)
    locals = {
      booking: booking,
      user: user,
      flights: FlightPresenter.new(booking.flight),
      url: URI.join("https://bawa.herokuapp.com/bookings/", booking.slug)
    }
    mail(to: user.email, subject: "Booking successful.") do |format|
      format.text { render locals: locals }
      format.html { render locals: locals }
    end
  end
end
