module UserCmd
  class LedgerDeposit < ApplicationCommand

    def initialize(xargs)
      args = xargs.stringify_keys
      return unless has_amount?(args)
      add_event(:ledger, Event::UserLedgerDeposited.new(deposit_opts(args)))
    end

    private

    def deposit_opts(opts)
      cmd_opts(opts).merge(opts.slice(*%w(uuid amount)))
    end

    def has_amount?(args)
      args["amount"]
    end
  end
end
