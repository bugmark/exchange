module Entities
  class IssueDetail < Grape::Entity
    expose :type           , documentation: { type: String  , desc: "Issue Type" }
    expose :uuid           , documentation: { type: String  , desc: "Issue UUID" }
    expose :exid           , documentation: { type: String  , desc: "TBD"        }
    expose :stm_repo_uuid  , documentation: { type: String  , desc: "TBD"        }
    expose :stm_issue_uuid , documentation: { type: String  , desc: "TBD"        }
    expose :stm_title      , documentation: { type: String  , desc: "TBD"        }
    expose :stm_status     , documentation: { type: String  , desc: "TBD"        }
    expose :stm_labels     , documentation: { type: String  , desc: "TBD"        }
    expose :xfields        , documentation: { type: String  , desc: "TBD"        }
    expose :jfields        , documentation: { type: String  , desc: "TBD"        }
    expose :num_contracts  , documentation: { type: Integer , desc: "TBD"        }
    expose :updated_at     , documentation: { type: DateTime, desc: "TBD"        }
  end
end