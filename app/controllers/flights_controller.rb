class FlightsController < ApplicationController
  def index
  end

  def search_flights
    available_flights = Flight.filter(
      when: params[:when],
      location: params[:location],
      destination: params[:destination]
    )

    flights = available_flights.map(&FlightPresenter.method(:new))

    @result = {
      count: flights.size,
      results: flights,
      passengers: params[:passengers]
    }

    respond_to do |format|
      format.html { render partial: "flights/search_result" }
      format.json do
        render json: @result.as_json(
          include: {
            departure_location: { only: [:name, :location] },
            arrival_location: { only: [:name, :location] }
          }
        )
      end
    end
  end
end
