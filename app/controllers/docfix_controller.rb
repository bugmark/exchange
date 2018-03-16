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
    @session_end = current_user.last_session_ended_at.strftime("%m-%d %H:%M:%S")
    @new_events  = current_user.new_event_lines
  end
end

