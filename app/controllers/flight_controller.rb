class FlightController < ApplicationController
  def index
  end

  def search_flights
    available_flights = Flight.filter(
      when: params[:when],
      location: params[:location],
      destination: params[:destination]
    )

    flights = []
    available_flights.each do |flight|
      flights << {
        id: flight.id,
        dtime: FlightPresenter.new(flight).departure_time,
        atime: FlightPresenter.new(flight).arrival_time,
        ddate: FlightPresenter.new(flight).ddate,
        adate: FlightPresenter.new(flight).adate,
        fnumber: flight.flight_number,
        airline: flight.airline,
        price: FlightPresenter.new(flight).flight_price,
        dport: {
          id: flight.departure_location.id,
          name: flight.departure_location.name,
          location: flight.departure_location.location
        },
        aport: {
          id: flight.arrival_location.id,
          name: flight.arrival_location.name,
          location: flight.arrival_location.location
        }
      }
    end

    @result = {
      count: flights.size,
      results: flights
    }

    respond_to do |format|
      format.html { render partial: "flight/search_result" }
      format.json { render json: @result.as_json }
    end
  end
end
