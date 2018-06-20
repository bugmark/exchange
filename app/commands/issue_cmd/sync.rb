module IssueCmd
  class Sync < ApplicationCommand

    def initialize(xargs)
      args = xargs.stringify_keys
      add_event :issue, Event::IssueSynced.new(issue_opts(args))
    end

    private

    def issue_opts(args)
      cmd_opts(args).merge(args).exclude("stm_comments").merge(lcl_opts)
    end

    def lcl_opts
      {synced_at: BugmTime.now}
    end
  end
end