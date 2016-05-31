require "rails_helper"

RSpec.describe UsersController, type: :controller do
  let(:password) { Faker::Internet.password(8) }
  let(:user_test_params) do
    {
      user: {
        first_name: "#{Faker::Name.first_name}xyz",
        last_name: "#{Faker::Name.last_name}xyz",
        email: Faker::Internet.email,
        password: password,
        username: "#{Faker::Name.last_name}xyz",
        password_confirmation: password
      }
    }
  end

  context "GET #new" do
    it "assigns a new user to the view" do
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end

    it "raises an error if missing params" do
      user_test_params[:user][:email] = "habu@kagumba"
      post :create, user_test_params
      should render_template("new")
    end
  end

  context "POST #create" do
    it "redirects to the login page" do
      post :create, user_test_params

      expect(response).to redirect_to(root_path)
    end
  end

  context "Get #check_email" do
    it "checks for existing emails" do
      post :check_email,
           user: { email: user_test_params[:email] },
           format: :json

      should respond_with(200)

      expect(response.body).to eq "true"
    end
  end

  context "Get #check_username" do
    it "checks for existing usernames" do
      post :check_username,
           user: { email: user_test_params[:username] },
           format: :json

      should respond_with(200)

      expect(response.body).to eq "true"
    end
  end
end
