module RepoCmd
  class GhSync < ApplicationCommand

    attr_subobjects      :repo
    attr_delegate_fields :repo

    def initialize(args)
      @repo = Repo.find_or_create_by(args)
    end

    def sync
      json = open(repo.json_url) {|io| io.read}
      JSON.parse(json).each do |el|
        attrs = {
          repo_id:   self.id         ,
          type:      "Bug::GitHub"   ,
          exref:     el["id"]        ,
          json_url:  el["url"]       ,
          html_url:  el["html_url"]  ,
          title:     el["title"]     ,
          labels:    el["labels"]    ,
          status:    el["state"]     ,
          synced_at: Time.now
        }
        bug = BugCmd::Sync.new(attrs)
        bug.save_event.project
      end
    end

    def transact_before_project
      repo.synced_at = Time.now
    end

    def self.from_event(event)
      instance = allocate
      instance.repo = Repo.find_or_create_by(event.data)
      instance
    end

    def event_data
      {id: repo.id}
    end
  end
end
