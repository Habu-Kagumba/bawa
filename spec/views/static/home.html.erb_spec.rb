require "rails_helper"

RSpec.describe "static/home.html.erb", type: :view do
  it "renders the app tagline." do
    render

    expect(rendered).to have_selector(
      "h1", text: "Bawa Secure and reliable flight booking")
  end
end
