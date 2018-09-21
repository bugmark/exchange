class Types::Exchange::EventType < Types::Base::Object
  field :id                , Int       , null: true
  field :event_type        , String    , null: true
  field :event_uuid        , String    , null: true
  field :cmd_type          , String    , null: true
  field :cmd_uuid          , String    , null: true
end
