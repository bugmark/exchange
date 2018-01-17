module Entities
  class PositionOverview < Grape::Entity
    expose :uuid      , documentation: { type: String, desc: "UUID"          }
  end
end
