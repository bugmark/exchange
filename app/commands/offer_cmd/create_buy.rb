module OfferCmd
  class CreateBuy < ApplicationCommand

    attr_subobjects :offer, :user
    attr_reader     :typ
    attr_delegate_fields :offer     , class_name: "Offer::Buy"
    attr_vdelegate       :maturation, :offer

    attr_accessor :deposit
    attr_accessor :profit

    validate :deposit_amount
    validate :profit_amount
    validate :user_balance

    # NOTE: the offer_args must contain either a price or a deposit
    def initialize(typ, offer_args)
      @typ     = typ                         # offer_bf or offer_bu .
      starg    = offer_args.stringify_keys
      @profit  = starg.delete("profit")  || 0
      @deposit = starg.delete("deposit") || 0
      @offer   = klas.new(default_values.merge(starg))
      @user    = User.find(offer.user_id)
    end

    def event_data
      offer.attributes
    end

    # def user_ids
    #   [user.id]
    # end

    def transact_before_project
      offer.status ||= 'open'
      if deposit != 0
        self.price = deposit.to_i / volume.to_f
      end

      if profit != 0
        self.price = 1.0 - (profit.to_i / volume.to_f)
      end
    end

    def influx_tags
      {
        side:    offer.side   ,
        user_id: offer.user_id
      }
    end

    def influx_fields
      {
        id:     offer.id     ,
        volume: offer.volume ,
        price:  offer.price
      }
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

    def profit_amount
      return true if profit.to_i == 0

      if profit.to_i > volume
        errors.add :profit, "must be less than volume"
        return false
      end
    end

    def deposit_amount
      return true if deposit.to_i == 0

      if deposit.to_i > volume
        errors.add :deposit, "must be less than volume"
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
