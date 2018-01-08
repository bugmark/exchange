module RepoCmd
  class GhCreate < ApplicationCommand

    def initialize(xargs)
      args = xargs.stringify_keys
      add_event :repo, Event::RepoCreated.new(repo_opts(args))
    end

    private

    def repo_opts(args)
      cmd_opts.merge(args).merge({"type" => "Repo::GitHub"})
    end
  end
end
