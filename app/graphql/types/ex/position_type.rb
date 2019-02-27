# Position type
class Types::Ex::PositionType < Types::Base::Object
  field :id                , Int       , null: false
  field :uuid              , String    , null: false
  field :volume            , Int       , null: false
  field :price             , Float     , null: false
  field :value             , Float     , null: false
  field :side              , String    , null: false
  field :offer_uuid        , String    , null: false
  field :user_uuid         , String    , null: false
  field :user              , UserType  , null: false
  field :offer             , OfferType , null: false
end

PositionType = Types::Ex::PositionType
