module Entities
  class ContractOverview < Grape::Entity
    expose :uuid       , documentation: { type: String, desc: "UUID"               }
    expose :status     , documentation: { type: String   , desc: "Contract Status" }
    expose :maturation , documentation: { type: DateTime , desc: "TBD"             }
  end
end
