class ReposController < ApplicationController

  def index
    @repos = Repo.all
  end

  def show
    @repo = Repo.find(params["id"])
  end

  def new
    @repo = Repo.new
  end

  def create

  end
end
