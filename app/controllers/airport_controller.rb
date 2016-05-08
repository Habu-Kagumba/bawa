class AirportController < ApplicationController
  def index
    airports = Airport.search(params[:q]).order("created_at DESC")

    result = {
      count: airports.size,
      results: airports.as_json(
        only: [:id, :name, :location]
      )
    }
    render json: result
  end
end
