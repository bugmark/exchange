module TrackerCmd
  class Create < ApplicationCommand

    TYPES = %w(GitHub Test)

    validate :valid_tracker_type

    def initialize(xargs)
      @args = xargs.stringify_keys
      add_event :tracker, Event::TrackerCreated.new(tracker_opts(@args))
    end

    private

    def valid_tracker_type
      return true if TYPES.include?(@args["type"])
      return true if TYPES.map {|x| "Tracker::#{x}"}.include?(@args["type"])
      errors.add "type", "must be one of (#{TYPES.join("|")})"
      return false
    end

    def tracker_type(type)
      return type if TYPES.map {|x| "Tracker::#{x}"}.include?(type)
      "Tracker::#{type}"
    end

    def tracker_opts(args)
      args["type"] = tracker_type(args["type"])
      cmd_opts(args).merge(args)
    end
  end
end
