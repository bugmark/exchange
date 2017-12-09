module OfferCmd
  class CreateSell < ApplicationCommand

    attr_subobjects      :offer
    attr_reader          :salable_position
    attr_delegate_fields :offer, class_name: "Offer::Sell"

    def initialize(position, attr)
      @salable_position = position
      @volume           = attr[:volume] || salable_position.volume
      @price            = attr[:price]  || salable_position.price
      @offer            = klas.new(sell_offer_params)
    end

    def event_data
      offer.attributes
    end

    def transact_before_project
      offer.status = "open"
    end

    def influx_tags
      {
        side: offer.side
      }
    end

    def user_ids
      [offer.user_id]
    end

    def influx_fields
      {
        id:     offer.id     ,
        volume: offer.volume ,
        price:  offer.price
      }
    end

    private

    def klas
      case salable_position.side
        when "unfixed" then Offer::Sell::Unfixed
        when "fixed"   then Offer::Sell::Fixed
        else raise "unknown position side (#{salable_position.side})"
      end
    end

    def sell_offer_params
      time_base = salable_position&.contract&.maturation || BugmTime.now
      range     = time_base-1.week..time_base+1.week
      {
        status:  "open"                            ,
        volume:  @volume                           ,
        price:   @price                            ,
        user:    salable_position.user             ,
        salable_position: salable_position         ,
        maturation_range: range                    ,
      }.merge(salable_position.offer.match_attrs)
    end
  end
end