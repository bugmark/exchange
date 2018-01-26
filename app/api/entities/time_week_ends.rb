module Entities
  class TimeWeekEnds < Grape::Entity
    expose :week_end, documentation: { type: String , desc: "Week end"     }
  end
end
