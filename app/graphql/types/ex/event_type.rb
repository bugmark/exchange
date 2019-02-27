# Event type
class Types::Ex::EventType < Types::Base::Object
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
  # field :user_uuids    , [String]  , null: true
  # field :users         , [Types::Ex::UserType], null: true
  # field :kong          , Types::Ex::UserType do
  #   description 'Kong kong'
  #   resolve ->(_obj, _args, _ctx) do
  #     ::User.first
  #   end
  # end
end
