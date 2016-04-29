require "rails_helper"

RSpec.describe Airport, type: :model do
  describe "validation" do
    subject { build(:airport) }

    it { should be_valid }
  end
end
