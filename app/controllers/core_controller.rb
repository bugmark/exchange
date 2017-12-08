class CoreController < ApplicationController

  layout 'core'

  before_action :authenticate_user!

  def new_login
    redirect_to "/core"
  end

  def new_signup
    redirect_to "/core"
  end
end

