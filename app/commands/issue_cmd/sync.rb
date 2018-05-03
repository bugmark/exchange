module IssueCmd
  class Sync < ApplicationCommand

    def initialize(xargs)
      args = xargs.stringify_keys
      add_event :issue, Event::IssueSynced.new(issue_opts(args))
    end

    private

    def issue_opts(args)
      cmd_opts.merge(args).exclude("stm_comments")
    end
  end
end