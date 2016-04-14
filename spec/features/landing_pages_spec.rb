require "rails_helper"

RSpec.feature "LandingPages", type: :feature do
  before do
    Capybara.default_driver = :poltergeist
  end

  scenario "the landing page should have the applications tagline." do
    visit root_path

    within "div.content" do
      expect(page).to have_selector(
        "h1", text: "Bawa Secure and reliable flight booking."
      )
    end
  end
end
