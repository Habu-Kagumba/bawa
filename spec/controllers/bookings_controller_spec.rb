require "rails_helper"

RSpec.describe BookingsController, type: :controller do
  before :all do
    create(:flight)
    create(:booking)
  end

  describe "Routes" do
    it { should route(:get, "/bookings").to(action: :index) }
    it { should route(:get, "/bookings/1").to(action: :show, id: 1) }
    it { should route(:get, "/bookings/new").to(action: :new) }
    it { should route(:get, "/bookings/1/edit").to(action: :edit, id: 1) }
    it { should route(:delete, "/bookings/1").to(action: :destroy, id: 1) }
  end

  describe "Index page" do
    before do
      get :index
    end

    it "renders correct template" do
      should render_template("index")
    end

    it "route resolves" do
      should respond_with(:success)
    end
  end

  describe "Show page" do
    before do
      get :show, id: 1
    end

    it "route resolves" do
      should respond_with(:success)
    end

    it "renders correct template" do
      should render_template("show")
    end
  end

  describe "New page" do
    before do
      get :new
    end

    it "route resolves" do
      should respond_with(:success)
    end

    it "renders correct template" do
      should render_template("new")
    end
  end

  describe "Edit page" do
    before do
      get :edit, id: 1
    end

    it "route resolves" do
      should respond_with(:success)
    end

    it "renders correct template" do
      should render_template("edit")
    end
  end

  describe "Destroy booking" do
    before do
      delete :destroy, id: 1
    end

    it "reoute resolves" do
      should respond_with(302)
    end
  end
end
