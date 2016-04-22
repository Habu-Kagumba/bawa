module UsersHelper
  def name(user)
    @name = "#{user[:first_name]} #{user[:last_name]}"
  end

  def gravatar_for(user)
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    image_tag(gravatar_url, alt: name(user), class: "gravatar")
  end
end
