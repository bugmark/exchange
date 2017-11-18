module OfferCmd
  class Suspend < ApplicationCommand

    attr_subobjects :offer
    attr_delegate_fields :offer, class_name: "Offer"

    def initialize(offer)
      @offer = Offer.find(offer.to_i)
    end

    def event_data
      offer.attributes
    end

    def transact_before_project
      offer.status = "suspended"
    end
  end
end