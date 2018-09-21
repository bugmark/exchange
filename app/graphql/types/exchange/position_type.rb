class Types::Exchange::PositionType < Types::Base::Object
  field :id                , Int       , null: true
  field :uuid              , String    , null: true
  field :offer_uuid        , String    , null: true
  field :user_uuid         , String    , null: true
end
