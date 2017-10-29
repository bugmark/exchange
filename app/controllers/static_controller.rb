class StaticController < ApplicationController
  def home
  end

  def help
  end

  def test
  end

  def chart
  end

  def data
    render plain: File.read("#{File.dirname(__FILE__)}/data.text")
  end
end

