require 'ext/hash'

module OfferCmd
  class CreateBuyNew < ApplicationCommand

    attr_accessor :typ, :args

    validate :user_balance

    # NOTE: the offer_args must contain either a price or a deposit
    def initialize(typ, offer_args)
      @typ  = typ
      @args = {}
      args  = offer_args.stringify_keys
      args  = to_num(args)
      args  = set_price(args)
      args  = set_type(args)
      add_event :offer, Event::OfferBuyCreated.new(args)
    end

    def user
      new_offer&.user
    end

    private

    def set_type(args)
      args.merge(type: offer_class)
    end

    def offer_class
      case typ
        when :offer_bf then "Offer::Buy::Fixed"
        when :offer_bu then "Offer::Buy::Unfixed"
        else raise "UNKNOWN OFFER TYPE #{typ}"
      end
    end

    # -----

    def to_num(args)
      args.floatify("price").intify(*%w(volume deposit profit))
    end

    def set_price(args)
      return args if args[:price]
      return args unless args[:volume]
      args[:price] = args[:deposit] / args[:volume]        if args[:deposit]
      args[:price] = 1.0 - (args[:profit] / args[:volume]) if args[:profit]
    end

    # -----

    def user_balance
      return true if new_offer.persisted?
      new_offer.poolable ? user_poolable_balance : user_not_poolable_balance
    end

    def user_poolable_balance
      offer_value = new_offer.value || new_offer.volume * new_offer.price
      if (user.balance - offer_value - user.token_reserve_not_poolable) > 0
        return true
      else
        errors.add :volume, "poolable offer exceeds user balance"
        return false
      end
    end

    def user_not_poolable_balance
      offer_value = new_offer.value || new_offer.volume * new_offer.price
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
