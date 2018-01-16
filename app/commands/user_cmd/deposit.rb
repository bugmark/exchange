module UserCmd
  class Deposit < ApplicationCommand

    # TODO
    # validate presence of user
    # validate amount

    def initialize(xargs)
      args = xargs.stringify_keys
      add_event(:usr, Event::UserDeposited.new(deposit_opts(args))) if has_amount?(args)
    end

    private

    def deposit_opts(opts)
      cmd_opts.merge(opts.slice(*%w(uuid amount)))
    end

    def has_amount?(args)
      args["amount"]
    end
  end
end
