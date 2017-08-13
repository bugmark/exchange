module RepoCmd
  class GhCreate < ApplicationCommand

    attr_subobjects :repo
    attr_delegate_fields :repo

    def initialize(args = {})
      @repo = Repo.find_or_create_by(args)
    end

    def self.from_event(event)
      instance = allocate
      instance.repo = Repo.find_or_create_by(event.data)
      instance
    end

    def event_data
      repo.attributes
    end
  end
end
