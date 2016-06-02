class FlightsController < ApplicationController
  def index
  end

  def search_flights
    @result = process_flights
    respond_to do |format|
      format.html { render partial: "flights/search_result" }
      format.json { render json: json_resp(@result) }
    end
  end

  private

  def get_flights
    Flight.filter(
      when: params[:when],
      location: params[:location],
      destination: params[:destination]
    )
  end

  def process_flights
    flights = get_flights.map(&FlightPresenter.method(:new))

    {
      count: flights.size,
      results: flights,
      passengers: params[:passengers]
    }
  end

  def json_resp(results)
    results.as_json(
      include: {
        departure_location: { only: [:name, :location] },
        arrival_location: { only: [:name, :location] }
      }
    )
  end
end
