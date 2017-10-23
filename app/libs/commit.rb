class Commit

  attr_reader :type, :bundle, :contract, :escrow, :amendment

  TYPES = %i(expand transfer reduce)

  def initialize(commit_type, bundle)
    @type   = commit_type
    @bundle = bundle
    raise "BAD commit type (#{commit_type})" unless TYPES.include(commit_type)
  end

  def generate() self.send(commit_type) end

  private

  def type_klas()      @type.to_s.capitalize                  end
  def amendment_klas() "Amendment::#{type_klas}".constantize  end
  def escrow_klas()    "Escrow::#{type_klas}".constantize     end

  def expand
    all_offers   = [bundle.offer] + bundle.counters
    max_start    = all_offers.map {|o| o.maturation_range.begin}.max
    min_end      = all_offers.map {|o| o.maturation_range.end}.min

    # find or generate contract
    matching  = bundle.offer.match_contracts.overlap(max_start..min_end)
    selected  = matching&.sort_by {|c| c.escrows.count}.first
    contract  = bundle.offer.match_contracts.first || Contract.new(contract_opts)
    amendment = Amendment::Expand.create(contract: contract, escrow: escrow)
    escrow    = Escrow::Expand.create(contract: contract, amendment: amendment)

    contract.maturation = [max_start, min_end].avg_time unless selected.present?

    maturation   = contract.persisted? ? contract.maturation : [max_start, min_end].avg_time
    avg_cprice   = bundle.counters.map(&:price).avg

    ([bundle.offer] + bundle.counters).each do |offer|
      Position.create(amendment: amendment, escrow: escrow, offer: offer)
      # refund release
      # generate reoffer
      # capture escrow - update user balance
      offer.update_attribute(status, 'crossed')
    end
  end

  def transfer
    contract  = "find contract"
    amendment = Amendment::Transfer.create(contract: contract)
    escrow    = Escrow::Transfer.create(contract: contract, amendment: amendment)

    ([bundle.offer] + bundle.counters).each do |offer|
      # create positions
      #
    end
  end

  def reduce
    contract = "find contract"
    escrow   = "generate escrow with negative values"
    amendment = Amendment::Reduce.create(contract: contract, escrow: escrow)
    [offer1, offer2].each do |offer|
      # generate zero-value position
      # transfer escrow back to stakeholders
    end
  end
end