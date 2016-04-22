require "rails_helper"

RSpec.describe User, type: :model do
  subject { build(:user) }

  describe "Create user" do
    subject do
      build(:user, password: "password", password_confirmation: "password")
    end
    it { should be_valid }
  end

  describe "Validations" do
    context "Firstname" do
      it { should validate_presence_of(:first_name) }
      it do
        should validate_length_of(:first_name).is_at_least(3).is_at_most(25)
      end
      it do
        should_not allow_values("Herb12", "23her", "/][\-=]").for(:first_name)
      end
    end

    context "Lastname" do
      it { should validate_presence_of(:last_name) }
      it do
        should validate_length_of(:last_name).is_at_least(3).is_at_most(25)
      end
      it { should_not allow_values("Kagumba12", "23her").for(:last_name) }
    end

    context "Username" do
      it { should validate_presence_of(:username) }
      it { should validate_length_of(:username).is_at_least(3).is_at_most(60) }
      it { should validate_uniqueness_of(:username).case_insensitive }
      it { should_not allow_values("habu.kagumba").for(:username) }
      it { should allow_values("habu_kagumba", "habu123").for(:username) }
    end

    context "Email" do
      it { should validate_presence_of(:email) }
      it { should validate_uniqueness_of(:email).case_insensitive }
      it { should_not allow_values("habu@com", "habugamil.com").for(:email) }
    end

    context "Password" do
      subject do
        build(:user, password: nil, password_confirmation: nil)
      end
      it { should validate_presence_of(:password) }
      it { should validate_length_of(:password).is_at_least(8).is_at_most(20) }
      it { should validate_confirmation_of(:password) }
      it { should have_secure_password }
    end
  end
end
