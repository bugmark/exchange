# Escrow type
class Types::Ex::EscrowType < Types::Base::Object
  field :id                , Int                             , null: true
  field :uuid              , String                          , null: true
  field :type              , String                          , null: true
  field :sequence          , Int                             , null: true
  field :contract_uuid     , String                          , null: true
  field :amendment_uuid    , String                          , null: true
  field :contract          , ContractType                    , null: false
  field :positions         , [PositionType] , null: false
end

EscrowType = Types::Ex::EscrowType
