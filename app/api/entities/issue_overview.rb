module Entities
  class IssueOverview < Grape::Entity
    expose :uuid      , documentation: { type: String, desc: "UUID"          }
  end
end
