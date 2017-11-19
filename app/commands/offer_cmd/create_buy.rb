module OfferCmd
  class CreateBuy < ApplicationCommand

    attr_subobjects :offer, :user
    attr_reader     :typ
    attr_delegate_fields :offer     , class_name: "Offer::Buy"
    attr_vdelegate       :maturation, :offer

    attr_accessor :stake

    validate :stake_amount
    validate :user_balance

    # NOTE: the offer_args must contain either a price or a stake
    def initialize(typ, offer_args)
      @typ   = typ                         # offer_bf or offer_bu
      starg  = offer_args.stringify_keys
      @stake = starg.delete("stake") || 0
      @offer = klas.new(default_values.merge(starg))
      @user  = User.find(offer.user_id)
    end

    def event_data
      offer.attributes
    end

    def transact_before_project
      offer.status = 'open'
      if stake != 0
        self.price = stake.to_i / volume.to_f
      end
    end

    private

    def user_balance
      return true if offer.persisted?
      offer.poolable ? user_poolable_balance : user_not_poolable_balance
    end

    def user_poolable_balance
      offer_value = offer.value || offer.volume * offer.price
      if (user.balance - offer_value - user.token_reserve_not_poolable) > 0
        return true
      else
        errors.add :volume, "poolable offer exceeds user balance"
        return false
      end
    end

    def user_not_poolable_balance
      offer_value = offer.value || offer.volume * offer.price
      return true unless offer_value > user.token_available
      errors.add :volume, "non-poolable offer exceeds user balance"
      return false
    end

    def stake_amount
      return true if stake.to_i == 0

      if stake.to_i > volume
        errors.add :stake, "must be less than volume"
        return false
      end
    end

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
