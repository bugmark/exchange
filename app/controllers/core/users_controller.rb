module Core
  class UsersController < ApplicationController

    layout 'core'

    def show
      @user = User.find(params["id"])
    end
  end
end
