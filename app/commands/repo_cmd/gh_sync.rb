require 'ext/array'

module RepoCmd
  class GhSync < ApplicationCommand

    attr_accessor :repo

    def initialize(args)
      @repo = Repo.find_or_create_by(args)
      sync_bugs
    end

    def self.from_repo(repo)
      instance = allocate
      instance.repo = repo
      instance.send(:sync_bugs)
      instance
    end

    private

    def sync_bugs
      issues = Octokit.issues(repo.name)
      issues.each_with_index do |el, idx|
        attrs = {
          stm_repo_id: repo.id           ,
          type:        "Bug::GitHub"     ,
          exid:        el["id"]          ,
          stm_title:   el["title"]       ,
          stm_labels:  labels_for(el)    ,
          stm_status:  el["state"]       ,
          comments:    comments_for(el)  ,
          html_url:    el["html_url"]    ,
          synced_at:   BugmTime.now
        }.stringify_keys
        add_event("bug#{idx}".to_sym, Event::BugSynced.new(event_opts(attrs)))
      end
      add_event :repo, Event::RepoSynced.new(event_opts(uuid: repo.uuid))
    end

    def event_opts(args)
      cmd_opts.merge(args)
    end

    def labels_for(el)
      el["labels"].map {|x| x[:name]}.join(", ")
    end

    def comments_for(el)
      body = Octokit.issue(repo.name, el["number"])[:body]
      list = Octokit.issue_comments(repo.name, el["number"])
      lmap = list.blank? ? nil : list.map {|el| el["body"]}.join(" | ")
      base = [body, lmap].without_blanks.join(" | ")
      return "" if base.blank? || base.empty?
      base
    end
  end
end
