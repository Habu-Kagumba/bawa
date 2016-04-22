require "rails_helper"

RSpec.describe StaticController, type: :controller do
  describe "Routing" do
    context "visit to home" do
      it do
        should route(:get, "/").to(action: :home)
      end
    end
  end

  describe "Templates" do
    context "visit home page" do
      before { get :home }

      it { should render_template("home") }
      it { should render_with_layout("application") }
    end
  end
end
