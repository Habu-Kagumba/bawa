Faker::Code.class_eval do
  class << self
    def flight(range=1..12)
      random = Random::DEFAULT
      substring = ((2..9).to_a + ("A".."Z").to_a).join
      range.map { substring[random.rand(substring.size)] }.join
    end

    def airline
      [
        "Kenya Airways", "AirKenya", "Fly540", "South African Airways",
        "Safair", "Air Tanzania", "Precision Air", "Safari Plus", "Air Uganda",
        "Eagle Air", "EA Airlines", "RwandAir", "Air Arabia Egypt", "Air Cairo",
        "Alexandria Airlines", "TAT Nigeria", "Max Air", "Kabo Air",
        "Senegal Airlines", "British Airways", "KLM"
      ].sample
    end
  end
end
