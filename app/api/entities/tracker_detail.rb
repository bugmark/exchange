module Entities
  class TrackerDetail < Grape::Entity
    expose :type       , documentation: { type: String , desc: "Tracker Type" }
    expose :uuid       , documentation: { type: String , desc: "Tracker UUID" }
    expose :name       , documentation: { type: String , desc: "Tracker Name" }
    expose :issue_count, documentation: { type: Integer, desc: "# open issues"} do |tracker|
      tracker.issues.open.count
    end
    expose :issues     , documentation: { type: String, desc: "issue UUIDs", is_array: true }, if: {issues: "true"} do |tracker|
      tracker.issues.map {|issue| issue.uuid}
    end
  end
end
