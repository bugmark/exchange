# Tracker type
class Types::Exc::TrackerType < Types::Base::Object
  field :id,        Int,                        null: true
  field :uuid,      String,                     null: true
  field :name,      String,                     null: true
  field :issues,    [Types::Exc::IssueType],    null: true
  field :offers,    [Types::Exc::OfferType],    null: true
  field :contracts, [Types::Exc::ContractType], null: true
end
