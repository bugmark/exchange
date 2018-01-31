require "grape-swagger"

module V1
  class App < Grape::API

    http_basic do |email, password|
      dev_log email
      dev_log password
      @current_user = User.find_by_email(email)
      @current_user && @current_user.valid_password?(password)
    end

  end
end
