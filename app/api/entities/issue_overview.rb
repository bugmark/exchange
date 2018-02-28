module Entities
  class IssueOverview < Grape::Entity
    expose :type       , documentation: { type: String   , desc: "type"        }
    expose :uuid       , documentation: { type: String   , desc: "UUID"        }
    expose :exid       , documentation: { type: String   , desc: "external ID" }
  end
end
