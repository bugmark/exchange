class BingsController < ApplicationController
  def show
    @bing = BingForm.new(user: current_user)
  end
end
