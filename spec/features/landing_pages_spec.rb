require "rails_helper"

RSpec.feature "LandingPages" do
  before do
    visit root_path
  end

  scenario "Landing page tagline." do
    within "main.content" do
      expect(page).to have_selector(
        "h1", text: "Bawa Secure and reliable flight booking."
      )
    end
  end

  scenario "Signin button" do
    expect(page).to have_link("Sign in")
  end
end
