module Entities
  class UserDetail < Grape::Entity
    expose :uuid      , documentation: { type: String, desc: "UUID"          }
    expose :email     , documentation: { type: String, desc: "eMail Address" }
    expose :balance   , documentation: { type: Float , desc: "Balance"       }
    expose :offers    , documentation: { type: String, is_array: true }, using: Entities::OfferOverview   , if: {offers: "true"}
    expose :positions , documentation: { type: String, is_array: true }, using: Entities::PositionOverview, if: {positions: "true"}
  end
end
