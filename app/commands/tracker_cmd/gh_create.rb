module TrackerCmd
  class GhCreate < ApplicationCommand

    def initialize(xargs)
      args = xargs.stringify_keys
      add_event :tracker, Event::TrackerCreated.new(tracker_opts(args))
    end

    private

    def tracker_opts(args)
      cmd_opts.merge(args).merge({"type" => "Tracker::GitHub"})
    end
  end
end
