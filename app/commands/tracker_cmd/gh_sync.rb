require 'ext/array'

module TrackerCmd
  class GhSync < ApplicationCommand

    attr_accessor :tracker

    def initialize(args)
      @tracker = Tracker.find_by(args)
      sync_bugs
    end

    def self.from_tracker(tracker)
      instance = allocate
      instance.tracker = tracker
      instance.send(:sync_bugs)
      instance
    end

    private

    def sync_bugs
      issues = Octokit.issues(tracker.name)
      return if issues.blank?
      issues.each_with_index do |el, idx|
        attrs = {
          stm_tracker_uuid: tracker.uuid           ,
          type:          "Issue::GitHub"     ,
          exid:          el["id"]          ,
          stm_title:     el["title"]       ,
          stm_labels:    labels_for(el)    ,
          stm_status:    el["state"]       ,
          comments:      comments_for(el)  ,
          html_url:      el["html_url"]    ,
          synced_at:     BugmTime.now
        }.stringify_keys
        add_event("bug#{idx}".to_sym, Event::IssueSynced.new(event_opts(attrs)))
      end
      add_event :tracker, Event::TrackerSynced.new(event_opts(uuid: tracker.uuid))
    end

    def event_opts(args)
      cmd_opts(args).merge(args)
    end

    def labels_for(el)
      el["labels"].map {|x| x[:name]}.join(", ")
    end

    def comments_for(el)
      body = Octokit.issue(tracker.name, el["number"])[:body]
      list = Octokit.issue_comments(tracker.name, el["number"])
      lmap = list.blank? ? nil : list.map {|el| el["body"]}.join(" | ")
      base = [body, lmap].without_blanks.join(" | ")
      return "" if base.blank? || base.empty?
      base
    end
  end
end
