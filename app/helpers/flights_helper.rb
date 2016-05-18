module FlightsHelper
  def logo(url = Faker::Company.logo)
    image_tag(url)
  end

  def flight_expired(ddate)
    ddate > Date.today
  end
end
