require "csv"

class Seed
  def plant_seeds
    [Airport, Flight].map(&:destroy_all)
    airports
    900.times { flights }
    puts "#{Flight.count} flights and #{Airport.count} airports seeded"
  end

  def airports
    parse_airports.each do |row|
      save_airports(row)
    end
  end

  def flights
    dept_arr_date = Faker::Time.forward(50, :all)
    Flight.create!(
      departure_date: dept_arr_date,
      arrival_date: dept_arr_date + Random.rand(0..23).hours,
      departure_location_id: Airport.order("RANDOM()").first.id,
      arrival_location_id: Airport.order("RANDOM()").first.id,
      flight_number: Faker::Code.flight(1..6),
      airline: Faker::Code.airline,
      price: Faker::Commerce.price
    )
  end

  private

  def parse_airports
    CSV.parse(
      File.read(Rails.root.join("lib", "seeds", "airports_sub.csv")),
      headers: true
    )
  end

  def save_airports(row)
    Airport.create!(
      name: row["name"],
      location: row["location"]
    )
  end
end

Seed.new.plant_seeds
