module Entities
  class Event < Grape::Entity
    # include API::Entities::Defaults

    expose :id        , documentation: {type: Integer, desc: "Sequential ID"   }
    expose :event_type, documentation: {type: String,  desc: "Event Type"      }
    expose :event_uuid, documentation: {type: String,  desc: "Event UUID"      }
    expose :cmd_type  , documentation: {type: String,  desc: "Command Type"    }
    expose :cmd_uuid  , documentation: {type: String,  desc: "Command UUID"    }
    expose :local_hash, documentation: {type: String,  desc: "Local Hash"      }
    expose :chain_hash, documentation: {type: String,  desc: "Blockchain Hash" }
    expose :payload   , documentation: {type: Hash,    desc: "Event Payload"   }
    expose :user_uuids, documentation: {type: String,  desc: "User UUIDs", is_array: true }
  end
end