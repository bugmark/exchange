class IssuesController < ApplicationController
  def index
    @issues = Issue.all
  end
end
