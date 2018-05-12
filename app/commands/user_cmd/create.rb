module UserCmd
  class Create < ApplicationCommand

    def initialize(xargs)
      args = xargs.stringify_keys
      args["encrypted_password"] = pwd_digest(args["password"])
      args["amount"]             = args["balance"] if args["balance"]
      args["uuid"]               = args["uuid"] || SecureRandom.uuid
      add_event(:usr1, Event::UserCreated.new(usr_opts(args)))
      add_event(:usr2, Event::UserDeposited.new(deposit_opts(args))) if has_amount?(args)
    end

    def user
      @usr2 || @usr1
    end

    private

    def pwd_digest(password)
      User.new("password" => password).encrypted_password
    end

    def usr_opts(opts)
      cmd_opts.merge(opts.slice(*%w(uuid email name encrypted_password)))
    end

    def deposit_opts(opts)
      cmd_opts.merge(opts.slice(*%w(uuid amount)))
    end

    def has_amount?(args)
      args["amount"]
    end
  end
end
