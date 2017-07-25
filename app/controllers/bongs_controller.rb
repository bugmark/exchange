class BongsController < ApplicationController
  def new
    @bing = ContractForm.new(user: current_user)
  end
end
