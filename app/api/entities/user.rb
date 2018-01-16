module Entities
  class User < Grape::Entity
    expose :uuid      , documentation: { type: String, desc: "UUID"          }
    expose :usermail  , documentation: { type: String, desc: "eMail Address" }
    expose :balance   , documentation: { type: Float , desc: "Balance"       }
    expose :offers    , documentation: { type: String, desc: "Open Offers"   , is_array: true   }
    expose :positions , documentation: { type: String, desc: "Open Positions", is_array: true   }
  end
end
