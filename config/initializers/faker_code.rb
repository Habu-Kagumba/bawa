Faker::Code.class_eval do
  class << self
    def flight(range=1..12)
      random = Random::DEFAULT
      substring = ((2..9).to_a + ("A".."Z").to_a).join
      range.map { substring[random.rand(substring.size)] }.join
    end
  end
end
