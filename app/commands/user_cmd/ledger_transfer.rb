module UserCmd
  class LedgerTransfer < ApplicationCommand

    def initialize(src_uuid, tgt_args)
      debit_args  = clean_opts(xargs.stringify_keys.merge("uuid" => src_uuid))
      credit_args = clean_opts(xargs.stringify_keys)
      return unless has_amount?(tgt_args)
      add_event(:credit, Event::UserLedgerCredited.new(credit_args))
      add_event(:debit , Event::UserLedgerDebited.new(debit_args))
    end

    private

    def clean_opts(opts)
      cmd_opts(opts).merge(opts.slice(*%w(uuid amount)))
    end

    def has_amount?(args)
      args["amount"]
    end
  end
end
