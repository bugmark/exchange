module Entities
  class TimeNow < Grape::Entity
    expose :bugmark_time, documentation: { type: String , desc: "Current Bugmark Time"     }
    expose :day_offset  , documentation: { type: Integer, desc: "Day Offset from Realtime" }
  end
end
