module OfferBuyCmd
  class Cancel < ApplicationCommand

    attr_subobjects :offer
    attr_delegate_fields :offer, class_name: "Offer::Buy"

    def initialize(offer)
      @offer = offer
    end

    def event_data
      offer.attributes
    end

    def transact_before_project
      offer.status = "cancelled"
    end
  end
end #