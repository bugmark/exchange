module Docfix
  class UsersController < ApplicationController

    layout 'docfix'

    def show
      @user = User.find(params["id"])
    end
  end
end
