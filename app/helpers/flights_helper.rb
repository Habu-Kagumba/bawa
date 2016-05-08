module FlightsHelper
  def logo
    image_tag(Faker::Company.logo)
  end
end
