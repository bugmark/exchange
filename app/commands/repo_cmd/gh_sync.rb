require 'ext/array'

module RepoCmd
  class GhSync < ApplicationCommand

    attr_subobjects      :repo
    attr_delegate_fields :repo

    def initialize(args)
      @repo = Repo.find_or_create_by(args)
    end

    def self.from_repo(repo)
      instance = allocate
      instance.repo = repo
      instance
    end

    def transact_before_project
      sync_bugs
      repo.synced_at = BugmTime.now
    end

    def self.from_event(event)
      instance = allocate
      instance.repo = Repo.find_or_create_by(event.data)
      instance
    end

    def event_data
      {id: repo.id}
    end

    private

    def sync_bugs
      issues = Octokit.issues(repo.name)
      issues.each do |el|
        attrs = {
          stm_repo_id: self.id           ,
          type:        "Bug::GitHub"     ,
          exref:       el["id"]          ,
          stm_title:   el["title"]       ,
          stm_labels:  labels_for(el)    ,
          stm_status:  el["state"]       ,
          stm_jfields: comments_for(el)  ,
          html_url:    el["html_url"]    ,
          synced_at:   BugmTime.now
        }
        bug = BugCmd::Sync.new(attrs)
        bug.project
      end
    end

    def labels_for(el)
      el["labels"].map {|x| x[:name]}.join(", ")
    end

    def comments_for(el)
      body = Octokit.issue(repo.name, el["number"])[:body]
      list = Octokit.issue_comments(repo.name, el["number"])
      lmap = list.blank? ? nil : list.map {|el| el["body"]}.join(" | ")
      base = [body, lmap].without_blanks.join(" | ")
      return {} if base.blank? || base.empty?
      {comments: base}
    end
  end
end
