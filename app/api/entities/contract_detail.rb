module Entities
  class ContractDetail < Grape::Entity
    expose :type           , documentation: { type: String   , desc: "Contract Type"   }
    expose :uuid           , documentation: { type: String   , desc: "Contract UUID"   }
    expose :status         , documentation: { type: String   , desc: "Contract Status" }
    expose :prototype_uuid , documentation: { type: String   , desc: "TBD"             }
    expose :num_escrows    , documentation: { type: Integer  , desc: "TBD"             }
    expose :num_amendments , documentation: { type: Integer  , desc: "TBD"             }
    expose :num_positions  , documentation: { type: Integer  , desc: "TBD"             }
    expose :maturation     , documentation: { type: DateTime , desc: "TBD"             }
    expose :stm_issue_uuid , documentation: { type: String   , desc: "TBD"             }
    expose :stm_repo_uuid  , documentation: { type: String   , desc: "TBD"             }
    expose :stm_title      , documentation: { type: String   , desc: "TBD"             }
    expose :stm_status     , documentation: { type: String   , desc: "TBD"             }
    expose :stm_labels     , documentation: { type: String   , desc: "TBD"             }
  end
end
