module Entities
  class UserOverview < Grape::Entity
    expose :uuid     , documentation: { type: String,  desc: "UUID"            }
    expose :email    , documentation: { type: String,  desc: "eMail address"   }
    expose :balance  , documentation: { type: Float,   desc: "account balance" }
  end
end
