require 'ext/hash'

module OfferCmd
  class CreateBuy < ApplicationCommand

    attr_reader :typ

    validate :user_balance
    validate :deposit_amount
    validate :profit_amount

    # NOTE: the offer_args must contain either a price or a deposit
    def initialize(typ, offer_args)
      @typ  = typ
      args  = offer_args.stringify_keys
      args  = to_num(args)
      args  = set_price(args)
      args  = set_type(args)
      args  = set_uuid(args)
      @args = args
      add_event :offer, Event::OfferBuyCreated.new(event_opts(args))
    end

    def user
      offer_new&.user
    end

    private

    def event_opts(opts)
      cmd_opts.merge(opts).without("deposit", "profit")
    end

    def set_type(args)
      args.merge(type: offer_class)
    end

    def set_uuid(args)
      return args if args[:uuid] || args["uuid"]
      args.merge(uuid: SecureRandom.uuid)
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
      return args unless args["volume"]
      args["price"] = args["deposit"].to_f / args["volume"]        if args["deposit"]
      args["price"] = 1.0 - (args["profit"].to_f / args["volume"]) if args["profit"]
      args
    end

    # -----

    def user_balance
      return true if offer_new.persisted?
      return false unless offer_new.valid?
      offer_new.poolable ? user_poolable_balance : user_not_poolable_balance
    end

    def user_poolable_balance
      offer_value = offer_new.value || offer_new.volume * offer_new.price
      if (user.balance - offer_value - user.token_reserve_not_poolable) > 0
        return true
      else
        errors.add "volume", "poolable offer exceeds user balance"
        return false
      end
    end

    def user_not_poolable_balance
      offer_value = offer_new.value || offer_new.volume * offer_new.price
      return true unless offer_value > user.token_available
      errors.add "volume", "non-poolable offer exceeds user balance"
      return false
    end

    def profit_amount
      profit = @args["profit"] || 0
      volume = @args["volume"]

      return true if profit.to_i == 0
      if profit.to_i > volume
        errors.add "profit", "must be less than volume"
        return false
      end
    end

    def deposit_amount
      deposit = @args["deposit"] || 0
      volume  = @args["volume"]

      return true if deposit.to_i == 0

      if deposit.to_i > volume
        errors.add "deposit", "must be less than volume"
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
