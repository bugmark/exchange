module OfferBuyCmd
  class Create < ApplicationCommand

    attr_subobjects :offer, :user
    attr_reader     :typ
    attr_delegate_fields :offer, class_name: "Offer::Buy"
    attr_vdelegate :maturation_date, :offer

    def initialize(typ, offer_args)
      @typ   = typ
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
      typ == :bid ? Offer::Buy::Bid : Offer::Buy::Ask
    end

    def default_values
      {
        status: "open"
      }
    end
  end
end