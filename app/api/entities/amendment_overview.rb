module Entities
  class AmendmentOverview < Grape::Entity
    expose :uuid      , documentation: { type: String, desc: "UUID"          }
  end
end
