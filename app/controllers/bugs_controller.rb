class BugsController < ApplicationController
  def index
    @bugs = Bug.all
  end
end
