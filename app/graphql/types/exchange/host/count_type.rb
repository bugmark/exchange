class Types::Exchange::Host::CountType < Types::Base::Object

  field :users, Int, null: true, description: "User Count"
  def users() User.count end

  field :trackers, Int, null: true, description: "Tracker Count"
  def trackers() Tracker.count end

  field :issues, Int, null: true, description: "Issue Count"
  def issues() Issue.count end

  field :offers, Int, null: true, description: "Offer Count"
  def offers() Offer.count end

  field :offers_open, Int, null: true, description: "Open Offer Count"
  def offers_open() Offer.open.count end

  field :offers_open_bf, Int, null: true, description: "Open Offer BF Count"
  def offers_open_bf() Offer.open.is_buy_fixed.count end

  field :offers_open_bu , Int, null: true, description: "Open Offer BU Count"
  def offers_open_bu() Offer.open.is_buy_unfixed.count end

  field :contracts, Int, null: true, description: "Contracts Count"
  def contracts() Contract.count end

  field :contracts_open, Int, null: true, description: "Open Contracts Count"
  def contracts_open() Contract.open.count end

  field :positions, Int, null: true, description: "Positions Count"
  def positions() Position.count end

  field :amendments, Int, null: true, description: "Amendments Count"
  def amendments() Amendment.count end

  field :escrows, Int, null: true, description: "Escrows Count"
  def escrows() Escrow.count end

  field :events, Int, null: true, description: "Events Count"
  def events() Event.count end

end

