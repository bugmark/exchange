module RepoCmd
  class Create < ApplicationCommand

    TYPES = %w(GitHub Test)

    validate :valid_repo_type

    def initialize(xargs)
      @args = xargs.stringify_keys
      add_event :repo, Event::RepoCreated.new(repo_opts(@args))
    end

    private

    def valid_repo_type
      return true if TYPES.include?(@args["type"])
      return true if TYPES.map {|x| "Repo::#{x}"}.include?(@args["type"])
      errors.add "type", "must be one of (#{TYPES.join("|")})"
      return false
    end

    def repo_type(type)
      return type if TYPES.map {|x| "Repo::#{x}"}.include?(type)
      "Repo::#{type}"
    end

    def repo_opts(args)
      args["type"] = repo_type(args["type"])
      cmd_opts.merge(args)
    end
  end
end
