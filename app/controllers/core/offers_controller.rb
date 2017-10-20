require 'ostruct'

module Core
  class OffersController < ApplicationController

    layout 'core'

    def index
      @filter = set_filter(params)
      @offers = @filter ? @filter.obj.offers.open : Offer.open
    end

    def cross
      ask_id = params["id"]
      result = ContractCmd::Cross.new(ask_id).save_event.project
      if result
        redirect_to "/rewards/#{result.id}"
      else
        redirect_to "/rewards"
      end
    end

    def retract
      OfferCmd::Retract.new(params["id"]).save_event.project
      redirect_to "/core/offers"
    end

    private

    def set_filter(params)
      keylist = %w(stm_repo_id stm_bug_id user_id)
      return nil unless params.keys.any? { |key| keylist.include?(key) }
      key = params.keys.find {|key| keylist.include?(key)}
      obj = case key
        when "stm_repo_id" then Repo.find(params[key])
        when "stm_bug_id"  then Bug.find(params[key])
        when "user_id"     then User.find(params[key])
      end
      OpenStruct.new(key: key, obj: obj)
    end
  end
end