require "rails_helper"

RSpec.describe User, type: :model do
  subject { build(:user) }

  describe "User model validations" do
    it "user factory should be valid" do
      should be_valid
    end

    it { should validate_presence_of(:first_name) }
    it do
      should validate_length_of(:first_name).is_at_least(3).is_at_most(25)
    end
    it do
      should_not allow_values("Herb12", "23her", "/][\-=]").for(:first_name)
    end

    it { should validate_presence_of(:last_name) }
    it do
      should validate_length_of(:last_name).is_at_least(3).is_at_most(25)
    end
    it { should_not allow_values("Kagumba12", "23her").for(:last_name) }

    it { should validate_presence_of(:username) }
    it { should validate_length_of(:username).is_at_least(3).is_at_most(60) }
    it { should validate_uniqueness_of(:username).case_insensitive }
    it { should_not allow_values("habu.kagumba").for(:username) }
    it { should allow_values("habu_kagumba", "habu123").for(:username) }

    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should_not allow_values("habu@com", "habugamil.com").for(:email) }

    describe "user model password validation" do
      subject do
        build(:user, password: nil, password_confirmation: nil)
      end
      it { should validate_presence_of(:password) }
      it { should validate_length_of(:password).is_at_least(8).is_at_most(20) }
      it { should validate_confirmation_of(:password) }
      it { should have_secure_password }
    end
  end

  describe "user model before_save methods" do
    it "downcases email on save" do
      test_email = Faker::Internet.email
      email_user = create(:user, email: test_email.upcase)
      expect(email_user.email).to be_eql test_email
    end

    it "capitalizes first_name and last_name on save" do
      test_first_name = "#{Faker::Name.first_name}xyz"
      test_last_name = "#{Faker::Name.last_name}xyz"
      test_user = create(
        :user,
        first_name: test_first_name.downcase,
        last_name: test_last_name.downcase
      )
      expect(test_user.first_name).to be_eql test_first_name
      expect(test_user.last_name).to be_eql test_last_name
    end
  end

  describe "user model associations" do
    it { should have_many(:bookings) }
  end

  describe "user session encryption" do
    it "assigns remember_digest used to remember the user" do
      UserAuthenticator.new.remember_user(subject)
      expect(subject.remember_digest).not_to be_nil
    end

    it "can forget a user by deleting remember_digest" do
      UserAuthenticator.new.forget_user(subject)
      expect(subject.remember_digest).to be_nil
    end

    it "can check if a user is authenticated" do
      UserAuthenticator.new.remember_user(subject)
      expect(
        UserAuthenticator.
        new(subject).
        authenticated?(subject.remember_token)
      ).to be true
    end
  end
end
