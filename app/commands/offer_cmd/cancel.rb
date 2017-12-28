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

    # def transact_before_project
    #   offer.status = "canceled"
    # end

    def influx_tags
      {
        side: offer.side
      }
    end

    def influx_fields
      {
        id:     offer.id     ,
        volume: offer.volume ,
        price:  offer.price
      }
    end
  end
end