require "rails_helper"

RSpec.describe UsersController, type: :controller do
  let(:password) { Faker::Internet.password(8) }
  let(:user_test_params) do
    {
      user: attributes_for(:user)
    }
  end

  describe "GET #new" do
    subject { assigns(:user) }

    it "assigns a new user to the view" do
      get :new
      is_expected.to be_a_new(User)
      should render_template("new")
    end
  end

  describe "POST #create" do
    it "logs in successful created user" do
      post :create, user_test_params
      should set_flash[:success]
      should set_session[:user_id]
    end

    it "fails on validation errors" do
      user_test_params[:user][:email] = "habu@kagumba"
      post :create, user_test_params
      should render_template("new")
      should_not set_session[:user_id]
    end
  end

  describe "GET #check_email" do
    it "checks for existing emails" do
      post :check_email,
           user: { email: user_test_params[:email] },
           format: :json

      should respond_with(200)

      expect(response.body).to eq "true"
    end
  end

  describe "Get #check_username" do
    it "checks for existing usernames" do
      post :check_username,
           user: { email: user_test_params[:username] },
           format: :json

      should respond_with(200)

      expect(response.body).to eq "true"
    end
  end
end
