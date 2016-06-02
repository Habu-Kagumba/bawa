class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ Constants.EMAIL_REGEX
      record.errors[attribute] << (
        options[:message] || "not a valid email address")
    end
  end
end
