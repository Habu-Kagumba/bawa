class UserAuthenticator
  def initialize(user = nil, session = nil, cookies = nil)
    @user = user
    @session = session
    @cookies = cookies
  end

  def get_user(email_username)
    if Constants.EMAIL_REGEX.match(email_username)
      User.find_by(email: email_username)
    else
      User.find_by(username: email_username)
    end
  end

  def create_session(params)
    user = get_user(params[:email_username])
    if user && user.authenticate(params[:password])
      login(user)
      params[:remember_me] == "1" ? remember(user) : forget(user)
    end
  end

  def remember_user(user)
    user.remember_token = new_token
    user.update_attribute(
      :remember_digest,
      digest(user.remember_token)
    )
  end

  def remember(user)
    the_user = the_user(user)
    remember_user(the_user)
    @cookies.permanent.signed[:user_id] = the_user.id
    @cookies.permanent[:remember_token] = the_user.remember_token
  end

  def forget_user(user)
    user.update_attribute(:remember_digest, nil)
  end

  def forget(user)
    the_user = the_user(user)
    forget_user(the_user)
    @cookies.delete(:user_id)
    @cookies.delete(:remember_token)
  end

  def authenticated?(remember_token)
    return false if @user.remember_digest.nil?
    BCrypt::Password.new(@user.remember_digest).is_password?(remember_token)
  end

  def login(user = nil)
    @session[:user_id] = the_user(user).id
  end

  def logout
    forget(the_user)
    @session.delete(:user_id)
  end

  private

  def new_token
    SecureRandom.urlsafe_base64
  end

  def digest(string)
    BCrypt::Password.create(string, cost: BCrypt::Engine.cost)
  end

  def the_user(user = nil)
    user || @user
  end
end
