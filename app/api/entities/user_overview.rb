module Entities
  class UserOverview < Grape::Entity
    expose :uuid      , documentation: { type: String, desc: "UUID"          }
    expose :usermail  , documentation: { type: String, desc: "eMail Address" }
  end
end
