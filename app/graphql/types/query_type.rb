class Types::QueryType < Types::Base::Object

  # ------------------------------------------------------
  field :hello, String, null: false do
    description 'GraphQL test - Hello World!'
  end

  def hello
    'Hello World!'
  end

  # ------------------------------------------------------
  field :host, Types::Exchange::HostType, null: true do
    description 'Host info'
  end

  def host
    Types::Exchange::HostKlas.new
  end

  # ------------------------------------------------------
  field :amendments, [Types::Exchange::AmendmentType], null: true do
    description 'Amendment list'
  end

  def amendments
    Amendment.all
  end

  # ------------------------------------------------------
  field :amendment, Types::Exchange::AmendmentType, null: true do
    description 'Amendment info'
    argument :id, Int, required: true
  end

  def amendment(id:)
    Amendment.find(id)
  end

  # ------------------------------------------------------
  field :events, [Types::Exchange::EventType], null: true do
    description 'Event list'
    argument :limit, Integer, default_value: 20, required: false
  end

  def events(limit:)
    Event.all.order(:id => :desc).limit(limit)
  end

  # ------------------------------------------------------
  field :event, Types::Exchange::EventType, null: true do
    description 'Event info'
    argument :id, Int, required: true
  end

  def event(id:)
    Event.find(id)
  end

  # ------------------------------------------------------
  field :escrows, [Types::Exchange::EscrowType], null: true do
    description 'Escrow list'
  end

  def escrows
    Escrow.all
  end

  # ------------------------------------------------------
  field :escrow, Types::Exchange::EscrowType, null: true do
    description 'Escrow info'
    argument :id, Int, required: true
  end

  def escrow(id:)
    Escrow.find(id)
  end

  # ------------------------------------------------------
  field :trackers, [Types::Exchange::TrackerType], null: true do
    description 'Tracker list'
  end

  def trackers
    Tracker.all
  end

  # ------------------------------------------------------
  field :tracker, Types::Exchange::TrackerType, null: true do
    description 'Tracker info'
    argument :id, Int, required: true
  end

  def tracker(id:)
    Tracker.find(id)
  end

  # ------------------------------------------------------
  field :issues, [Types::Exchange::IssueType], null: true do
    description 'Issue list'
  end

  def issues
    Issue.all
  end

  # ------------------------------------------------------
  field :issue, Types::Exchange::IssueType, null: true do
    description 'Issue info'
    argument :id, Int, required: true
  end

  def issue(id:)
    Issue.find(id)
  end

  # ------------------------------------------------------
  field :positions, [Types::Exchange::PositionType], null: true do
    description 'Position list'
  end

  def positions
    Position.all
  end

  # ------------------------------------------------------
  field :position, Types::Exchange::PositionType, null: true do
    description 'Position info'
    argument :id, Int, required: true
  end

  def position(id:)
    Position.find(id)
  end

  # ------------------------------------------------------
  field :offers, [Types::Exchange::OfferType], null: true do
    description 'Offer list'
  end

  def offers
    Offer.all
  end

  # ------------------------------------------------------
  field :offer, Types::Exchange::OfferType, null: true do
    description 'Offer info'
    argument :id, Int, required: true
  end

  def offer(id:)
    Offer.find(id)
  end

  # ------------------------------------------------------
  field :contracts, [Types::Exchange::ContractType], null: true do
    description 'Contract list'
  end

  def contracts
    Contract.all
  end

  # ------------------------------------------------------
  field :contract, Types::Exchange::ContractType, null: true do
    description 'Contract info'
    argument :id, Int, required: true
  end

  def contract(id:)
    Contract.find(id)
  end

  # ------------------------------------------------------
  field :users, [Types::Exchange::UserType], null: true do
    description 'User list'
  end

  def users
    User.all
  end

  # ------------------------------------------------------
  field :user, Types::Exchange::UserType, null: true do
    description 'User info'
    argument :id, Int, required: true
  end

  def user(id:)
    User.find(id)
  end

end
