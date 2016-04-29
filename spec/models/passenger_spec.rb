require "rails_helper"

RSpec.describe Passenger, type: :model do
  subject(:passenger) do
    create(:flight)
    create(:booking)
    create(:passenger)
  end

  describe "Validation" do
    context "when I create a booking" do
      it "should be valid" do
        expect(passenger).to be_valid
      end
    end
  end
end
