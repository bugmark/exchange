module Entities
  class HostCount < Grape::Entity
    expose :host_name      , documentation: { type: String  , desc: "Bugmark Hostname"                     }
    expose :users          , documentation: { type: Integer , desc: "Number of Users"                      }
    expose :trackers          , documentation: { type: Integer , desc: "Number of Trackers"                      }
    expose :issues         , documentation: { type: Integer , desc: "Number of Issues"                     }
    expose :offers         , documentation: { type: Integer , desc: "Number of Offers"                     }
    expose :offers_open    , documentation: { type: Integer , desc: "Number of Open Offers"                }
    expose :offers_open_bf , documentation: { type: Integer , desc: "Number of Open Offers to Buy Fixed"   }
    expose :offers_open_bu , documentation: { type: Integer , desc: "Number of Open Offers to Buy Unfixed" }
    expose :contracts      , documentation: { type: Integer , desc: "Number of Contracts"                  }
    expose :contracts_open , documentation: { type: Integer , desc: "Number of Open Contracts"             }
    expose :positions      , documentation: { type: Integer , desc: "Number of Positions"                  }
    expose :amendments     , documentation: { type: Integer , desc: "Number of Amendments"                 }
    expose :escrows        , documentation: { type: Integer , desc: "Number of Escrows"                    }
    expose :events         , documentation: { type: Integer , desc: "Number of Events"                     }
  end
end
