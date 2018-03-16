require 'time'

class String

  def id
    self.to_i
  end

  def is_userid?
    self.to_i.to_s == self
  end
  alias is_userid is_userid?
  alias is_integer is_userid?
  alias is_integer? is_userid?

  def is_email_address?
    self.match(/^[a-zA-Z0-9\_\.\-]+@[a-zA-Z0-9\_\-\.]+\.[a-zA-Z]{2,4}$/)
  end
  alias is_email_address is_email_address?

  def is_username?
    self.match /^@?[A-Za-z][A-Za-z0-9\-\_]+$/
  end
  alias is_username is_username?

  def is_fn?
    self.match /[^\d]/
  end
  alias is_fn is_fn?

  def identification_type
    return 'email'    if self.is_email_address?
    return 'username' if self.is_username?
    return 'userid'   if self.is_userid?
    nil
  end

  def is_true?
    %w(yes 1 true y).include? self.downcase
  end
  alias  is_true is_true?

  def username_normalize
    return self[1..-1] if self[0] == '@'
    self
  end

  def to_snake
    self.strip.squeeze(' ').gsub(' ','_').downcase
  end

  def phone_dasherize
    return self if self[0] != '1'
    return self if self.length != 11
    self[1..3] + '-' + self[4..6] + '-' + self[7..10]
  end

  def phone_normalize
    return self if self[0] == 1
    '1' + self.gsub('-','')
  end

  def to_time
    Time.parse(self)
  end
end
