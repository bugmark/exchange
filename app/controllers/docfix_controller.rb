class DocfixController < ApplicationController

  layout 'docfix'

  before_action :authenticate_user!

  def new_login
  end

  def new_signup
  end
end

