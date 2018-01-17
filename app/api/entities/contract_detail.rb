module Entities
  class ContractDetail < Grape::Entity
    expose :type , documentation: { type: String, desc: "Contract Type" }
    expose :uuid , documentation: { type: String, desc: "Contract UUID" }
  end
end
