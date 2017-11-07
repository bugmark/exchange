module Docfix
  class ProfilesController < ApplicationController

    layout 'docfix'

    before_action :authenticate_user!

    def show
    end

    def my_issues
    end

    def my_offers
    end

    def my_contracts
    end

    def saved_searches
    end

    def my_wallet
    end

    def my_watchlist
    end

    def settings
    end
  end
end

