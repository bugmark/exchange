module Entities
  class PositionDetail < Grape::Entity
    expose :uuid           , documentation: { type: String , desc: "Position UUID" }
    expose :side           , documentation: { type: String , desc: "TBD"           }
    expose :offer_uuid     , documentation: { type: String , desc: "TBD"           }
    expose :user_uuid      , documentation: { type: String , desc: "TBD"           }
    expose :escrow_uuid    , documentation: { type: String , desc: "TBD"           }
    expose :amendment_uuid , documentation: { type: String , desc: "TBD"           }
    expose :parent_uuid    , documentation: { type: String , desc: "TBD"           }
    expose :volume         , documentation: { type: Integer, desc: "TBD"           }
    expose :price          , documentation: { type: Float  , desc: "TBD"           }
    expose :value          , documentation: { type: Float  , desc: "TBD"           }
  end
end
