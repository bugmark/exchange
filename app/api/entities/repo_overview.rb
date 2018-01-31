module Entities
  class RepoOverview < Grape::Entity
    expose :uuid       , documentation: { type: String, desc: "Repo UUID" }
    expose :name       , documentation: { type: String, desc: "Repo Name" }
    expose :issue_count, documentation: { type: Integer, desc: "# open issues"} do |repo|
      repo.issues.open.count
    end
  end
end
