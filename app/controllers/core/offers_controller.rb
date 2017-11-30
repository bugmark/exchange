require 'ostruct'

module Core
  class OffersController < ApplicationController

    layout 'core'

    def index
      @filter = set_filter(params)
      @offers = @filter ? @filter.obj.offers.open : Offer.open
    end

    def show
      @offer = Offer.find(params["id"])
    end

    def cross
      offer    = Offer.find(params["id"])
      result1 = ContractCmd::Cross.new(offer, :expand).project
      result2 = ContractCmd::Cross.new(offer, :transfer).project
      if result1 || result2
        redirect_to "/core/contracts/#{offer.position.contract.id}"
      else
        redirect_to "/core/offers/#{offer.id}"
      end
    end

    def cancel
      OfferCmd::Cancel.new(params["id"]).project
      redirect_to "/core/users/#{current_user.id}"
    end

    def take
      offer   = Offer.find(params["id"])
      binding.pry
      counter = OfferCmd::CreateBuy.new(offer.counter_type, offer.counter_args(current_user)).project.offer
      cross   = ContractCmd::Cross.new(counter, offer.cross_operation).project
      redirect_to "/core/contracts/#{cross.commit.contract.id}"
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