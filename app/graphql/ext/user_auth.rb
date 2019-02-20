# wrapper for user login
class UserAuth

  attr_reader :mail, :pass, :user

  def initialize(mail, pass)
    @pass = pass
    @mail = mail
    lcl_user = User.find_by_email(mail)
    @user = lcl_user&.valid_password?(pass) ? lcl_user : nil
  end

  def basic_token
    base = ActionController::HttpAuthentication::Basic
    cred = base.encode_credentials(mail, pass)
    user ? cred : nil
  end

  def id()      user&.id;      end
  def uuid()    user&.uuid;    end
  def name()    user&.name;    end
  def email()   user&.email;   end
  def mobile()  user&.mobile;  end
  def balance() user&.balance; end

end
