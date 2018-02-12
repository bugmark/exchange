module Entities
  class ContractOverview < Grape::Entity
    expose :uuid , documentation: { type: String, desc: "UUID" }
  end
end
