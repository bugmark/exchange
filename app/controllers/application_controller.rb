class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # def after_sign_in_path_for(_resource_or_scope)
  #   binding.pry
  #   "/docfix"
  # end

  def signed_in_root_path(_resoruce_or_scope)
    "/docfix"
  end

  def after_sign_out_path_for(_resource)
    "/docfix"
  end
end
