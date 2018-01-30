module Entities
  class RepoDetail < Grape::Entity
    expose :type       , documentation: { type: String , desc: "Repo Type" }
    expose :uuid       , documentation: { type: String , desc: "Repo UUID" }
    expose :name       , documentation: { type: String , desc: "Repo Name" }
    expose :issue_count, documentation: { type: Integer, desc: "# open issues"} do |repo|
      repo.issues.open.count
    end
    expose :issues     , documentation: { type: String, desc: "issue UUIDs", is_array: true }, if: {issues: "true"} do |repo|
      repo.issues.map {|issue| issue.uuid}
    end
  end
end
