require 'ext/hash'

module OfferCmd
  class CreateBuy < ApplicationCommand

    attr_reader :typ, :args

    validate :valid_user_balance
    validate :valid_deposit_amount
    validate :valid_profit_amount

    # NOTE: the offer_args must contain either a price, deposit or profit
    def initialize(typ, offer_args)
      @typ  = typ
      @args = ArgHandler.new(offer_args, self)
                .apply(&:default_values)
                .apply(&:numify)
                .apply(&:set_uuid)
                .apply(&:set_type)
                .apply(&:set_price)
                .apply(&:set_maturation)
                .apply(&:event_opts)
                .apply(&:stringify)
                .to_h
      add_event :offer, Event::OfferBuyCreated.new(clean_args)
    end

    def user
      offer_new&.user
    end

    def maturation
      offer_new&.maturation
    end
    
    private

    def clean_args
      @args.without("deposit", "profit")
    end

    def valid_user_balance
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

    def valid_deposit_amount
      deposit = @args["deposit"] || 0
      volume  = @args["volume"]

      return true if deposit.to_i == 0
      if deposit.to_i > volume
        errors.add "deposit", "must be less than volume"
        return false
      end
    end

    def valid_profit_amount
      profit = @args["profit"] || 0
      volume = @args["volume"]

      return true if profit.to_i == 0
      if profit.to_i > volume
        errors.add "profit", "must be less than volume"
        return false
      end
    end

    def offer_class
      case typ.to_s
        when "offer_bu" then Offer::Buy::Unfixed
        when "offer_bf" then Offer::Buy::Fixed
        else raise "unknown type (#{typ.to_s})"
      end
    end

    class ArgHandler

      attr_reader :args, :caller, :typ

      def initialize(args, caller)
        @args   = args.stringify_keys
        @caller = caller
        @typ    = caller.typ
      end

      def default_values
        @args["status"] = 'open'
        self
      end

      def set_uuid
        @args["uuid"] = SecureRandom.uuid unless @args["uuid"]
        self
      end

      def numify
        @args = @args.floatify("price").intify(*%w(volume deposit profit))
        self
      end

      def set_type
        args["type"] = caller.send(:offer_class)
        self
      end

      def stringify
        @args = @args.stringify_keys
        self
      end

      def set_maturation
        return self unless args["maturation_range"]
        @args["maturation_beg"] = args["maturation_range"].first
        @args["maturation_end"] = args["maturation_range"].last
        @args.delete("maturation_range")
        self
      end

      def set_price
        volume = @args["volume"]
        return self unless volume
        deposit = @args["deposit"]
        profit  = @args["profit"]
        @args["price"] = deposit.to_f / volume        if deposit
        @args["price"] = 1.0 - (profit.to_f / volume) if profit
        self
      end

      def event_opts
        @args = caller.send(:cmd_opts)
                  .merge(@args)
                  .stringify_keys
        self
      end

      def to_h
        @args
      end
    end
  end
end
