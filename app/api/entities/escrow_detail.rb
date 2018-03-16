module Entities
  class EscrowDetail < Grape::Entity
    expose :type , documentation: { type: String, desc: "Escrow Type" }
    expose :uuid , documentation: { type: String, desc: "Escrow UUID" }
  end
end
