require "csv"

class Seed
  def airports
    csv_txt = File.read(Rails.root.join("lib", "seeds", "airports_sub.csv"))
    csv = CSV.parse(csv_txt, headers: true)
    csv.each do |row|
      a = Airport.new
      a.name = row["name"]
      a.location = row["location"]
      a.save
    end
  end

  def flights
    dept_arr_date = Faker::Time.forward(50, :all)
    f = Flight.new
    f.departure_date = dept_arr_date
    f.arrival_date = dept_arr_date + Random.rand(0..23).hours
    f.departure_location_id = Airport.order("RANDOM()").first.id
    f.arrival_location_id = Airport.order("RANDOM()").first.id
    f.flight_number = Faker::Code.flight(1..6)
    f.airline = Faker::Code.airline
    f.price = Faker::Commerce.price
    f.save
  end

  def plant_seeds
    Airport.destroy_all
    Flight.destroy_all

    airports
    900.times { flights }

    puts "There are now #{Flight.count} flights in the db"
    puts "There are now #{Airport.count} airports in the db"
  end
end

bawa_data = Seed.new
bawa_data.plant_seeds
