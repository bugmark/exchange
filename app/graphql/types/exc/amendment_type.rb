# Amendment type
class Types::Exc::AmendmentType < Types::Base::Object
  field :id                , Int       , null: true
  field :uuid              , String    , null: true
  field :type              , String    , null: true
  field :sequence          , Int       , null: true
  field :contract_uuid     , String    , null: true
end
