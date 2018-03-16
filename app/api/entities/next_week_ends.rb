module Entities
  class NextWeekEnds < Grape::Entity
    expose :next_week_ends , documentation: {type: DateTime, desc: "Week end times", is_array: true}
  end
end
