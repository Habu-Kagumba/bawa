require "rails_helper"
include ActionView::Helpers::NumberHelper

RSpec.describe FlightPresenter, type: :presenter do
  let(:flight) { build_stubbed(:flight) }
  let(:presenter) { FlightPresenter.new(flight) }

  describe "flight model presenters" do
    it "adds the #flight_price method" do
      expect(presenter.flight_price).
        to be_eql number_to_currency(flight.price, unit: "$")
    end

    it "adds the #adate method" do
      expect(presenter.adate).to be_eql flight.arrival_date.strftime("%d %B")
    end

    it "adds the #ddate method" do
      expect(presenter.ddate).
        to be_eql flight.departure_date.strftime("%d %B %Y")
    end

    it "adds the #departure_time method" do
      expect(presenter.departure_time).
        to be_eql flight.departure_date.strftime("%H:%M")
    end

    it "adds the #arrival_time method" do
      expect(presenter.arrival_time).
        to be_eql flight.arrival_date.strftime("%H:%M")
    end
  end
end
