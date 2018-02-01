module Entities
  class OfferCreated < Grape::Entity
    expose :status     , documentation: { type: String, desc: "status"     }
    expose :event_uuid , documentation: { type: String, desc: "event UUID" }
    expose :offer_uuid , documentation: { type: String, desc: "offer UUID" }
  end
end
