module OfferCmd
  class Cancel < ApplicationCommand

    # attr_subobjects :offer
    # attr_delegate_fields :offer, class_name: "Offer"

    def initialize(offer)
      @offer = Offer.find(offer.to_i)
    end

    def event_data
      offer.attributes
    end

  end
end