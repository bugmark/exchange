require_relative "./count_klas"

class Types::Exchange::Host::CountType < Types::Base::Object
  field :users          , Int, null: true, description: "User Count"
  field :trackers       , Int, null: true, description: "Tracker Count"
  field :offers         , Int, null: true, description: "Offer Count"
  field :offers_open    , Int, null: true, description: "Open Offer Count"
  field :offers_open_bf , Int, null: true, description: "Open Offer BF Count"
  field :offers_open_bu , Int, null: true, description: "Open Offer BU Count"
  field :contracts      , Int, null: true, description: "Contracts Count"
  field :contracts_open , Int, null: true, description: "Open Contracts Count"
  field :positions      , Int, null: true, description: "Positions Count"
  field :amendments     , Int, null: true, description: "Amendments Count"
  field :escrows        , Int, null: true, description: "Escrows Count"
  field :events         , Int, null: true, description: "Events Count"
end

