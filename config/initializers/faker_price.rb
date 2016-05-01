Faker::Commerce.class_eval do
  class << self
    def price(range=100..1000.0)
      random = Random::DEFAULT
      (random.rand(range) * 1000).floor/1000.0
    end
  end
end
