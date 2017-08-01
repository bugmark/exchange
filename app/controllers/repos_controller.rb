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
    opts = params["repo"]
    @repo = Repo.find_or_create_by(url: opts["url"])
    if @repo.save
      @repo.update_attributes(valid_params(opts))
      redirect_to("/repos/#{@repo.id}")
    else
      render 'repos/new'
    end
  end

  private

  def valid_params(params)
    fields = Repo.attribute_names.map(&:to_sym)
    params.permit(fields)
  end
end
