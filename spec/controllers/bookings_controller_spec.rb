require "rails_helper"

RSpec.describe BookingsController, type: :controller do
  before :all do
    @user = create(:user)
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

    it "redirects to the login page" do
      should respond_with(302)
    end
  end

  describe "Show page is protected" do
    context "Anonymous user" do
      before do
        get :show, id: 1
      end
      it "redirects to the login page" do
        should respond_with(302)
      end
    end

    context "Registered user" do
      before do
        login_as @user
        get :show, id: 1
      end

      it "able to access the show page" do
        should respond_with(200)
      end
    end
  end

  describe "New page" do
    before do
      get :new
    end

    context "Anonymous user" do
      it "redirects to the login page" do
        should respond_with(302)
      end
    end

    context "Registered user" do
      before do
        login_as @user
        get :new, id: 1
      end

      it "able to access the show page" do
        should respond_with(200)
      end
    end
  end

  describe "Edit page" do
    before do
      get :edit, id: 1
    end

    context "Anonymous user" do
      it "redirects to the login page" do
        should respond_with(302)
      end
    end

    context "Registered user" do
      before do
        login_as @user
        get :edit, id: 1
      end

      it "able to access the show page" do
        should respond_with(200)
      end
    end
  end

  describe "Destroy booking" do
    before do
      delete :destroy, id: 1
    end

    context "Anonymous user" do
      it "redirects to the login page" do
        should respond_with(302)
      end
    end
  end
end
