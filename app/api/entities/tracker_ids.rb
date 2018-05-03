module Entities
  class TrackerIds < Grape::Entity
    expose :uuid       , documentation: { type: String, desc: "Tracker UUID" }
    expose :name       , documentation: { type: String, desc: "Tracker Name" }
    expose :type       , documentation: { type: String, desc: "Tracker Type" }
    expose :issue_count, documentation: { type: Integer, desc: "# open issues"} do |tracker|
      tracker.issues.open.count
    end
  end
end
