module Entities
  class OfferDetail < Grape::Entity
    expose :type , documentation: { type: String, desc: "Offer Type" }
    expose :uuid , documentation: { type: String, desc: "Offer UUID" }
  end
end
