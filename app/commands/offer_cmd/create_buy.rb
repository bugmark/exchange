module OfferCmd
  class CreateBuy < ApplicationCommand

    attr_subobjects :offer, :user
    attr_reader     :typ
    attr_delegate_fields :offer     , class_name: "Offer::Buy"
    attr_vdelegate       :maturation, :offer

    attr_accessor :tgt_escrow

    def initialize(typ, offer_args)
      @typ        = typ                          # offer_bf or offer_bu
      @tgt_escrow = offer_args.delete("tgt_escrow") || 0
      @offer      = klas.new(default_values.merge(offer_args))
      @user       = User.find(offer.user_id)
    end

    def event_data
      offer.attributes
    end

    def transact_before_project
      offer.status = 'open'
      if tgt_escrow != 0
        self.price = volume.to_f / tgt_escrow.to_i
      end
    end

    private

    def klas
      case typ.to_s
        when "offer_bu" then Offer::Buy::Unfixed
        when "offer_bf" then Offer::Buy::Fixed
        else raise "unknown type (#{typ.to_s})"
      end
    end

    def default_values
      {
        status: 'open'
      }.stringify_keys
    end
  end
end
