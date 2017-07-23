class ReposController < ApplicationController

  def index
    @repos = Repo.all
  end

  def show

  end

end
