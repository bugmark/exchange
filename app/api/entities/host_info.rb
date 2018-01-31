module Entities
  class HostInfo < Grape::Entity
    expose :host_name   , documentation: { type: String   , desc: "Bugmark Hostname"         }
    expose :host_time   , documentation: { type: DateTime , desc: "Current Bugmark Time"     }
    expose :day_offset  , documentation: { type: Integer  , desc: "Day Offset from Realtime" }
    expose :datastore   , documentation: { type: String   , desc: "permanent | mutable"      }
    expose :released_at , documentation: { type: String   , desc: "last release date"        }
  end
end
