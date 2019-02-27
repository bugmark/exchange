# Contract type
class Types::Ex::ContractType < Types::Base::Object
  field :id               , Int                             , null: true
  field :uuid             , String                          , null: true
  field :status           , String                          , null: true
  field :stm_issue_uuid   , String                          , null: true
  field :stm_tracker_uuid , String                          , null: true
  field :stm_title        , String                          , null: true
  field :stm_status       , String                          , null: true
  field :issue            , IssueType                       , null: false
  field :escrows          , [Types::Ex::EscrowType]   , null: false
  field :positions        , [PositionType] , null: false
end

ContractType = Types::Ex::ContractType
