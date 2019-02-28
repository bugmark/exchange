# Escrow type
class Types::Exc::EscrowType < Types::Base::Object
  field :id,             Int,                        null: true
  field :uuid,           String,                     null: true
  field :type,           String,                     null: true
  field :sequence,       Int,                        null: true
  field :contract_uuid,  String,                     null: true
  field :amendment_uuid, String,                     null: true
  field :contract,       Types::Exc::ContractType,   null: false
  field :positions,      [Types::Exc::PositionType], null: false
end
