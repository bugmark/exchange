class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :set_last_seen, if: proc { user_signed_in? }

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

  private

  def set_last_seen
    current_user.update_attribute(:last_seen_at, Time.now)
  end
end
