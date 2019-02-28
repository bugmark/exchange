# Issue type
class Types::Exc::IssueType < Types::Base::Object
  field :id                , Int       , null: true
  field :uuid              , String    , null: true
  field :sequence          , Int       , null: true
  field :stm_issue_uuid    , String    , null: true
  field :stm_tracker_uuid  , String    , null: true
  field :stm_title         , String    , null: true
  field :stm_status        , String    , null: true
end
