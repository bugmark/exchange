module OfferCmd
  class CreateSell < ApplicationCommand

    attr_subobjects      :sell_offer, :parent_position
    attr_delegate_fields :sell_offer, class_name: "Offer::Sell"

    def initialize(position, volume, price)
      @parent_position = position
      @volume          = volume
      @price           = price
      @sell_offer      = klas.new(sell_offer_params)
    end

    def event_data
      sell_offer.attributes
    end

    # def transact_before_project
    #   offer.status = "open"
    # end

    private

    def klas
      parent_position.side == :bid ? Offer::Sell::Bid : Offer::Sell::Ask
    end

    def sell_offer_params
      {
        status:  "open"                         ,
        volume:  @volume                        ,
        price:   @price                         ,
        user_id: parent_position.user.id        ,
        parent_position_id: parent_position.id  ,
      }.merge(parent_position.offer.match_attrs)
    end
  end
end