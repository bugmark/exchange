module Entities
  class OfferDetail < Grape::Entity
    expose :uuid          , documentation: { type: String , desc: "offer UUID"     }
    expose :type          , documentation: { type: String , desc: "offer type"     }
    expose :side          , documentation: { type: String , desc: "offer side"     }
    expose :intent        , documentation: { type: String , desc: "offer intent"   }
    expose :status        , documentation: { type: String , desc: "offer status"   }
    expose :volume        , documentation: { type: Integer, desc: "offer volume"   }
    expose :price         , documentation: { type: Float  , desc: "offer price"    }
    expose :value         , documentation: { type: Float  , desc: "offer value"    }
    expose :poolable      , documentation: { type: String , desc: "offer poolable" }
    expose :aon           , documentation: { type: String , desc: "offer aon"      }
    expose :stm_tracker_uuid , documentation: { type: String , desc: "stm_tracker_uuid"  }
    expose :stm_title     , documentation: { type: String , desc: "stm_title"      }
    expose :stm_status    , documentation: { type: String , desc: "stm_status"     }
    expose :expiration    , documentation: { type: Time   , desc: "expiration"     }
    expose :maturation    , documentation: { type: Time   , desc: "TBD"            }
    expose :maturation_beg, documentation: { type: Time   , desc: "maturation_beg" }
    expose :maturation_end, documentation: { type: Time   , desc: "maturation_end" }
  end
end
