class AirportsController < ApplicationController
  def index
    render json: json_resp(search_airport)
  end

  private

  def search_airport
    Airport.search(params[:q]).order("created_at DESC")
  end

  def json_resp(result)
    {
      count: result.size,
      results: result.as_json(
        only: [:id, :name, :location]
      )
    }
  end
end
