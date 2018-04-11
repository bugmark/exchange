module Entities
  class AmendmentIds < Grape::Entity
    expose :uuid      , documentation: { type: String, desc: "UUID"          }
  end
end
