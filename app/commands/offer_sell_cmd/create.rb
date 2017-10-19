module OfferSellCmd
  class Create < ApplicationCommand

    attr_subobjects :offer, :position
    attr_delegate_fields :offer     , class_name: "Offer::Sell"
    attr_vdelegate       :maturation, :offer

    def initialize(position, volume, price)
      @position = position
      @offer = klas.new(default_values.merge(offer_args))
      @user  = User.find(offer.user_id)
    end

    def event_data
      offer.attributes
    end

    def transact_before_project
      offer.status = "open"
    end

    private

    def klas
      position.offer.side == :bid ? Offer::Sell::Bid : Offer::Sell::Ask
    end

    def default_values
      {
        status: "open"
      }
    end
  end
end