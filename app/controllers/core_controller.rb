class CoreController < ApplicationController

  layout 'core'

  before_action :authenticate_user!

  def new_login
  end

  def new_signup
  end
end

