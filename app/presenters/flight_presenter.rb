require "delegate"

class FlightPresenter < SimpleDelegator
  include ActionView::Helpers::NumberHelper

  def flight_price
    number_to_currency(model.price, unit: "$")
  end

  def adate
    model.arrival_date.strftime("%d %B")
  end

  def ddate
    model.departure_date.strftime("%d %B %Y")
  end

  def departure_time
    model.departure_date.strftime("%H:%M")
  end

  def arrival_time
    model.arrival_date.strftime("%H:%M")
  end

  def model
    __getobj__
  end
end
