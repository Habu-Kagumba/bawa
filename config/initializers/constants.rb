class Constants
  def self.EMAIL_REGEX
    /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  end

  def self.USERNAME_REGEX
    /\A[a-zA-Z0-9_-]+\z/
  end

  def self.LETTERS_REGEX
    /\A[a-zA-Z ']+\z/
  end
end
