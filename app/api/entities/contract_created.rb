module Entities
  class ContractCreated < Grape::Entity
    expose :status        , documentation: { type: String, desc: "status"        }
    expose :event_uuid    , documentation: { type: String, desc: "event UUID"    }
    expose :contract_uuid , documentation: { type: String, desc: "contract UUID" }
  end
end
