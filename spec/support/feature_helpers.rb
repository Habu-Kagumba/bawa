module FeatureHelpers
  def login_as(user)
    @request.session[:user_id] = user.id
  end
end
