require "rails_helper"

RSpec.describe UsersController, type: :controller do
  before do
    @user = create(:user)
  end

  describe "Templates" do
    context "visit user new page" do
      before { get :new }

      it { should render_template("new") }
      it { should render_with_layout("application") }
    end
  end

  describe "Routing" do
    context "check username" do
      it do
        should route(
          :post, "users/check_username").
          to("users#check_username")
      end
    end

    context "check email" do
      it do
        should route(
          :post, "users/check_email").
          to("users#check_email")
      end
    end
  end

  describe "Validation" do
    context "validate email" do
      it do
        post :check_email, user: { email: @user.email },
                           format: :json

        should respond_with(200)

        expect(response.body).to eq "false"
      end
    end

    context "validate username" do
      it do
        post :check_username, user: { username: @user.username }, format: :json

        should respond_with(200)

        expect(response.body).to eq "false"
      end
    end
  end
end
