module Entities
  class EscrowOverview < Grape::Entity
    expose :uuid      , documentation: { type: String, desc: "UUID"          }
  end
end
