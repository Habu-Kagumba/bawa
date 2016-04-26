require "rails_helper"

RSpec.describe SessionsController, type: :controller do
  before :each do
    create(:user)
  end

  describe "Templates" do
    context "visit login page" do
      before { get :new }

      it { should render_template("new") }
      it { should render_with_layout("application") }
    end

    context "logout user" do
      before { delete :destroy }

      it { should redirect_to(login_path) }
    end
  end

  describe "Routing" do
    context "visit login page" do
      it do
        should route(:get, "/login").to(action: :new)
      end
    end

    context "logout user" do
      it do
        should route(:delete, "/logout").to(action: :destroy)
      end
    end
  end

  describe "Authentication" do
    before do
      @user = create(:user, id: 2, username: "habz", email: "h@k.com")
      login_as(@user)
      @user.remember
    end

    context "authenticated?" do
      it { expect(@user.authenticated?(@user.remember_token)).to be true }
      it { expect(@user.authenticated?("password")).to be false }
    end

    context "forget user" do
      before { @user.forget }
      it { expect(@user.remember_digest).to be_blank }
    end

    context "logout user" do
      before { delete :destroy }
      it { expect(session[:user_id]).to be_blank }
    end

    context "remember user" do
      it { expect(@user.remember_token).not_to be_blank }
    end
  end

  describe "Validation" do
    context "validate email for login" do
      it do
        post :check_username_email,
             session: { email_username: "herbert.kagumba@example.com" },
             format: :json

        should respond_with(200)

        expect(response.body).to eq "true"
      end
    end

    context "validate username for login" do
      it do
        post :check_username_email,
             session: { email_username: "habu" }, format: :json

        should respond_with(200)

        expect(response.body).to eq "true"
      end
    end
  end
end
