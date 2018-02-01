module Entities
  class OfferOverview < Grape::Entity
    expose :uuid   , documentation: { type: String, desc: "UUID" }
    expose :type   , documentation: { type: String, desc: "offer type" }
    expose :status , documentation: { type: String, desc: "offer status" }
  end
end
