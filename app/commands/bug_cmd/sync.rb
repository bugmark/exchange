module BugCmd
  class Sync < ApplicationCommand

    def initialize(xargs)
      args = xargs.stringify_keys
      add_event :bug, Event::BugSynced.new(bug_opts(args))
    end

    private

    def bug_opts(args)
      cmd_opts.merge(args)
    end
  end
end