module OfferCmd
  class CreateBuy < ApplicationCommand

    attr_subobjects :offer, :user
    attr_reader     :typ
    attr_delegate_fields :offer     , class_name: "Offer::Buy"
    attr_vdelegate       :maturation, :offer

    def initialize(typ, offer_args)
      @typ   = typ                          # bid or ask
      @offer = klas.new(default_values.merge(offer_args))
      @user  = User.find(offer.user_id)
    end

    def event_data
      offer.attributes
    end

    def transact_before_project
      offer.status = 'open'
    end

    private

    def klas
      case typ.to_s
        when "bid" then Offer::Buy::Bid
        when "ask" then Offer::Buy::Ask
        else raise "unknown type (#{typ.to_s})"
      end
    end

    def default_values
      {
        status: 'open'
      }
    end
  end
end
