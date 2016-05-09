module FlightsHelper
  def logo(url=Faker::Company.logo)
    image_tag(url)
  end
end
