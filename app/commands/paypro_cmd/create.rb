module PayproCmd
  class Create < ApplicationCommand

     INTERNAL = %w(XTS XBM)
     FIAT     = %w(USD EUR JPY CNY RUB GBP CAD AUD)
     DIGITAL  = %w(BTC ETH XMR)
     CURRENCIES = INTERNAL + FIAT + DIGITAL

    validate :valid_currency_type

    def initialize(xargs)
      @args = xargs.stringify_keys
      add_event :paypro, Event::PayproCreated.new(paypro_opts(@args))
    end

    private

    def valid_currency_type
      return true if CURRENCIES.include?(@args["currency"])
      errors.add "currency", "must be one of (#{CURRENCIES.join("|")})"
      return false
    end

    def paypro_opts(args)
      cmd_opts(args).merge(args)
    end
  end
end
