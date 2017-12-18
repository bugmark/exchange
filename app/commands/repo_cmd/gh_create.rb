module RepoCmd
  class GhCreate < ApplicationCommand

    # attr_subobjects      :repo
    # attr_delegate_fields :repo

    def initialize(xargs)
      args = xargs.stringify_keys
      add_event :repo, Event::RepoCreated.new(repo_opts(args))
    end

    private

    def repo_opts(args)
      cmd_opts.merge(args)
    end
  end
end
