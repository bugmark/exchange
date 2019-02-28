# Contract type
class Types::Exc::ContractType < Types::Base::Object
  field :id,               Int,                        null: true
  field :uuid,             String,                     null: true
  field :status,           String,                     null: true
  field :stm_issue_uuid,   String,                     null: true
  field :stm_tracker_uuid, String,                     null: true
  field :stm_title,        String,                     null: true
  field :stm_status,       String,                     null: true
  field :issue,            Types::Exc::IssueType,      null: false
  field :escrows,          [Types::Exc::EscrowType],   null: false
  field :positions,        [Types::Exc::PositionType], null: false
end
