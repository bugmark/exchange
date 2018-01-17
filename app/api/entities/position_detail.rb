module Entities
  class PositionDetail < Grape::Entity
    expose :type , documentation: { type: String, desc: "Position Type" }
    expose :uuid , documentation: { type: String, desc: "Position UUID" }
  end
end
