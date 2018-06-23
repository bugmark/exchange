require 'ext/hash'
require 'user_balance'

module GroupCmd
  class Create < ApplicationCommand

    attr_reader :args

    def initialize(args)
      @args = args
      add_event :group, Event::GroupCreated.new(group_opts(args))
    end

    private

    def group_opts(args)
      cmd_opts(args).merge(args)
    end
  end
end
