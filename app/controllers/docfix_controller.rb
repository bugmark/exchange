class DocfixController < ApplicationController

  layout 'docfix'

  before_action :authenticate_user!

  def new_login
    redirect_to "/docfix"
  end

  def new_signup
    redirect_to "/docfix"
  end

  def new_events
    # @new_events = current_user.new_event_lines
    binding.pry
    x = 1
  end
end

