module Entities
  class HostInfo < Grape::Entity
    expose :host_name   , documentation: { type: String   , desc: "Bugmark hostname"         }
    expose :host_time   , documentation: { type: DateTime , desc: "current Bugmark time"     }
    expose :day_offset  , documentation: { type: Integer  , desc: "day offset from realtime" }
    expose :usermail    , documentation: { type: String   , desc: "current user email"       }
    expose :datastore   , documentation: { type: String   , desc: "permanent | mutable"      }
    expose :released_at , documentation: { type: String   , desc: "last release date"        }
  end
end
