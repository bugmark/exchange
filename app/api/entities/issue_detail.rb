module Entities
  class IssueDetail < Grape::Entity
    expose :type , documentation: { type: String, desc: "Issue Type" }
    expose :uuid , documentation: { type: String, desc: "Issue UUID" }
  end
end
