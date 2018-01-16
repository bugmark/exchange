module UserCmd
  class Withdraw < ApplicationCommand

    # TODO
    # validate presence of user
    # validate amount

    def initialize(xargs)
      args = xargs.stringify_keys
      add_event(:usr, Event::UserWithdrawn.new(withdraw_opts(args))) if has_amount?(args)
    end

    private

    def withdraw_opts(opts)
      cmd_opts.merge(opts.slice(*%w(uuid amount)))
    end

    def has_amount?(args)
      args["amount"]
    end
  end
end
