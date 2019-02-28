# Host count methods
module CountMethods
  def users()          User.count end
  def trackers()       Tracker.count end
  def issues()         Issue.count end
  def offers()         Offer.count end
  def offers_open()    Offer.open.count end
  def offers_open_bf() Offer.open.is_buy_fixed.count end
  def offers_open_bu() Offer.open.is_buy_unfixed.count end
  def contracts()      Contract.count end
  def contracts_open() Contract.open.count end
  def positions()      Position.count end
  def amendments()     Amendment.count end
  def escrows()        Escrow.count end
  def events()         Event.count end
end

# Host count type
class Types::Exc::Host::CountType < Types::Base::Object
  include CountMethods
  field :users,          Int, null: true, description: 'User Count'
  field :trackers,       Int, null: true, description: 'Tracker Count'
  field :issues,         Int, null: true, description: 'Issue Count'
  field :offers,         Int, null: true, description: 'Offer Count'
  field :offers_open,    Int, null: true, description: 'Open Offer Count'
  field :offers_open_bf, Int, null: true, description: 'Open Offer BF Count'
  field :offers_open_bu, Int, null: true, description: 'Open Offer BU Count'
  field :contracts,      Int, null: true, description: 'Contracts Count'
  field :contracts_open, Int, null: true, description: 'Open Contracts Count'
  field :positions,      Int, null: true, description: 'Positions Count'
  field :amendments,     Int, null: true, description: 'Amendments Count'
  field :escrows,        Int, null: true, description: 'Escrows Count'
  field :events,         Int, null: true, description: 'Events Count'
end
