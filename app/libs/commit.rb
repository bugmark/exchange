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
    max_start    = "TBD"
    min_end      = "TBD"
    median_date  = "TBD"
    median_price = "TBD"

    # find or generate contract
    @contract = bundle.offer.match_contracts.first || Contract.new(contract_opts)
    @escrow   = Escrow.new

    ([bundle.offer] + bundle.counters).each do |offer|
      # generate position
      # refund release
      # generate reoffer
      # capture escrow - update user balance
      # update offer status from 'open' to 'crossed'
    end
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