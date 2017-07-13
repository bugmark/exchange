class ReposController < ApplicationController

  def index
    @repos = Repo.all
  end

end
