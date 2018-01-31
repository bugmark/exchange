module Entities
  class HostCount < Grape::Entity
    expose :host_name  , documentation: { type: String  , desc: "Bugmark Hostname"                }
    expose :host_time  , documentation: { type: String  , desc: "System Time"                     }
    expose :num_users  , documentation: { type: Integer , desc: "Number of Users"                 }
    expose :num_repos  , documentation: { type: Integer , desc: "Number of Repos"                 }
    expose :num_issues , documentation: { type: Integer , desc: "Number of Issues"                }
    expose :bu_offers  , documentation: { type: Integer , desc: "Number of Offers to Buy Fixed"   }
    expose :bf_offers  , documentation: { type: Integer , desc: "Number of Offers to Buy Unfixed" }
    expose :contracts  , documentation: { type: Integer , desc: "Number of Contracts"             }
    expose :positions  , documentation: { type: Integer , desc: "Number of Positions"             }
    expose :escrows    , documentation: { type: Integer , desc: "Number of Escrows"               }
    expose :amendments , documentation: { type: Integer , desc: "Number of Amendments"            }
    expose :events     , documentation: { type: Integer , desc: "Number of Events"                }
  end
end
