require "rails_helper"

RSpec.describe ApplicationHelper, type: :helper do
  describe "Page titles" do
    it "Builds default page title" do
      expect(helper.full_title).to eq "Bawa"
    end

    it "Builds a full page title" do
      expect(helper.full_title("Home")).to eq "Home | Bawa"
    end
  end
end
