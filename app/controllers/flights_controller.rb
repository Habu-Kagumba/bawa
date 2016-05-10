class FlightsController < ApplicationController
  def index
  end

  def search_flights
    available_flights = Flight.filter(
      when: params[:when],
      location: params[:location],
      destination: params[:destination]
    )

    passengers = params[:passengers]

    flights = []
    available_flights.map(&FlightPresenter.method(:new)).each do |flight|
      flights << {
        id: flight.id,
        dtime: flight.departure_time,
        atime: flight.arrival_time,
        ddate: flight.ddate,
        adate: flight.adate,
        fnumber: flight.flight_number,
        airline: flight.airline,
        price: flight.flight_price,
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
      results: flights,
      passengers: passengers
    }

    respond_to do |format|
      format.html { render partial: "flights/search_result" }
      format.json { render json: @result.as_json }
    end
  end
end
