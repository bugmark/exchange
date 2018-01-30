module Entities
  class UserDetail < Grape::Entity
    expose :uuid      , documentation: { type: String, desc: "UUID"          }
    expose :email     , documentation: { type: String, desc: "eMail Address" }
    expose :balance   , documentation: { type: Float , desc: "Balance"       }
    expose :offers    , documentation: { type: String, desc: "offer UUIDs"    , is_array: true }, if: {offers: "true"} do |user|
      user.offers.open.map {|off| off.uuid}
    end
    expose :positions , documentation: { type: String, desc: "posistion UUID, ", is_array: true }, if: {positions: "true"} do |user|
      user.positions.map {|pos| pos.uuid}
    end
  end
end
