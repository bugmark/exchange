class Commit

  attr_reader :commit_type, :bundle

  TYPES = %i(expand realloc reduce)

  def initialize(commit_type, bundle)
    @commit_type = commit_type
    @bundle      = bundle
    raise "BAD commit type (#{commit_type})" unless TYPES.include(commit_type)
  end

  def generate() self.send(commit_type) end

  private

  def expand
    all_offers   = [bundle.offer] + bundle.counters
    max_start    = all_offers.map {|o| o.maturation_range.begin}.max
    min_end      = all_offers.map {|o| o.maturation_range.end}.min

    # find or generate contract
    matching = bundle.offer.match_contracts.overlap(max_start..min_end)
    selected = matching&.sort_by {|c| c.escrows.count}.first
    contract = bundle.offer.match_contracts.first || Contract.new(contract_opts)
    escrow   = Escrow.new

    contract.maturation = [max_start, min_end].avg_time unless selected.present?

    maturation   = contract.persisted? ? contract.maturation : [max_start, min_end].avg_time
    avg_cprice   = bundle.counters.map(&:price).avg

    ([bundle.offer] + bundle.counters).each do |offer|
      # generate position
      Position.create
      # refund release
      # generate reoffer
      # capture escrow - update user balance
      # update offer status from 'open' to 'crossed'
    end
    # create an attach an amendment
  end

  def realloc
    "TBD"
  end

  def reduce
    @contract = "find contract"
    @escrow   = "generate escrow with negative values"
    [offer1, offer2].each do |offer|
      # generate zero-value position
      # transfer escrow back to stakeholders
    end
  end
end