module OfferCmd
  class CreateSell < ApplicationCommand

    attr_subobjects      :offer #, :parent_position
    attr_reader          :parent_position
    attr_delegate_fields :sell_offer, class_name: "Offer::Sell"

    def initialize(position, attr)
      @parent_position = position
      @volume          = attr[:volume]
      @price           = attr[:price]
      @offer           = klas.new(sell_offer_params)
    end

    def event_data
      offer.attributes
    end

    def transact_before_project
      offer.status = "open"
    end

    private

    def klas
      parent_position.side == 'bid' ? Offer::Sell::Bid : Offer::Sell::Ask
    end

    def sell_offer_params
      time_base = parent_position&.contract&.maturation || Time.now
      range     = time_base-1.week..time_base+1.week
      {
        status:  "open"                           ,
        volume:  @volume                          ,
        price:   @price                           ,
        user:    parent_position.user             ,
        parent_position: parent_position          ,
        maturation_range: range                   ,
      }.merge(parent_position.offer.match_attrs)
    end
  end
end