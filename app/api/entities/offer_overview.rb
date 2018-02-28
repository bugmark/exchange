module Entities
  class OfferOverview < Grape::Entity
    expose :uuid      , documentation: { type: String   , desc: "UUID"         }
    expose :type      , documentation: { type: String   , desc: "offer type"   }
    expose :status    , documentation: { type: String   , desc: "offer status" }
    expose :volume    , documentation: { type: Integer  , desc: "offer volume" }
    expose :price     , documentation: { type: Float    , desc: "offer price"  }
    expose :maturation, documentation: { type: DateTime , desc: "TBD"          }
  end
end
