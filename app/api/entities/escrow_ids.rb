module Entities
  class EscrowIds < Grape::Entity
    expose :uuid      , documentation: { type: String, desc: "UUID"          }
  end
end
