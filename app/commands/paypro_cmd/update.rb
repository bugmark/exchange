module PayproCmd
  class Update < ApplicationCommand

    # TODO
    # validate presence of user
    # validate amount

    def initialize(xargs)
      args = xargs.stringify_keys
      add_event(:usr, Event::PayproUpdated.new(paypro_opts(args))) if has_name?(args)
    end

    private

    def paypro_opts(opts)
      cmd_opts(opts).merge(opts.slice(*%w(uuid name)))
    end

    def has_name?(args)
      args["amount"]
    end
  end
end
