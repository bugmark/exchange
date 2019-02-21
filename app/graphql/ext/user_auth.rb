# wrapper for user login
class UserAuth

  attr_reader :mail, :pass, :user

  def initialize(mail, pass)
    @pass = pass
    @mail = mail
    @user = User.find_by_email(mail)
  end

  def valid_password?
    user.valid_password?(pass)
  end

  def basic_token
    base = ActionController::HttpAuthentication::Basic
    cred = base.encode_credentials(mail, pass)
    valid_password? ? cred : nil
  end

  def id()      user&.id;      end
  def uuid()    user&.uuid;    end
  def name()    user&.name;    end
  def email()   user&.email;   end
  def mobile()  user&.mobile;  end
  def balance() user&.balance; end

end
