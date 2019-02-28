# Event type
class Types::Exc::EventType < Types::Base::Object
  field :id            , Int, null: true
  field :date          , GraphQL::Types::ISO8601DateTime , null: true
  field :class         , String    , null: true
  field :local_hash    , String    , null: true
  field :chain_hash    , String    , null: true
  field :event_type    , String    , null: true
  field :event_uuid    , String    , null: true
  field :cmd_type      , String    , null: true
  field :cmd_uuid      , String    , null: true
  field :note          , String    , null: true
  field :users         , [Types::Exc::UserType], null: true
end
