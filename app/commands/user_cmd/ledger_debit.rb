module UserCmd
  class LedgerDebit < ApplicationCommand

    def initialize(xargs)
      args = xargs.stringify_keys
      return unless has_amount?(args)
      add_event(:usr, Event::UserLedgerDebited.new(withdraw_opts(args)))
    end

    private

    def withdraw_opts(opts)
      cmd_opts(opts).merge(opts.slice(*%w(uuid amount)))
    end

    def has_amount?(args)
      args["amount"]
    end
  end
end
