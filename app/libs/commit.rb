require 'ostruct'

class Commit

  attr_reader :type, :bundle, :contract, :escrow, :amendment

  TYPES = %i(expand transfer reduce)

  def initialize(bundle)
    @type   = bundle.type
    @bundle = bundle
    raise "BAD commit type (#{type})" unless TYPES.include?(type)
  end

  def generate() self.send(type); self end

  private

  def expand_position(offer, ctx, price)
    posargs = {
      volume:    offer.volume      ,
      price:     price             ,
      amendment: ctx.amendment     ,
      offer:     ctx.offer         ,
      escrow:    ctx.escrow        ,
      user:      offer.obj.user    ,
    }
    Position.create(posargs)
    # refund release
    # generate reoffer
    # capture escrow - update user balance
    offer.obj.update_attribute(:status, 'crossed')
  end

  def expand
    ctx = OpenStruct.new
    ctx.all_offers = [bundle.offer] + bundle.counters
    ctx.max_start  = ctx.all_offers.map {|o| o.obj.maturation_range.begin}.max
    ctx.min_end    = ctx.all_offers.map {|o| o.obj.maturation_range.end}.min

    # find or generate contract
    ctx.matching  = bundle.offer.obj.match_contracts.overlap(ctx.max_start, ctx.min_end)
    ctx.selected  = ctx.matching.sort_by {|c| c.escrows.count}.first
    ctx.contract  = @contract = ctx.selected || begin
      date = [ctx.max_start, ctx.min_end].avg_time
      attr = bundle.offer.obj.match_attrs.merge(maturation: date)
      Contract.create(attr)
    end

    # generate amendment, escrow, price
    ctx.amendment = Amendment::Expand.create(contract: contract)
    ctx.escrow    = Escrow::Expand.create(contract: contract, amendment: amendment)

    # calculate offer/counter price
    ctx.counter_price = bundle.counters.map {|el| el.obj.price}.max
    ctx.offer_price   = 1.0 - ctx.counter_price

    expand_position(bundle.offer, ctx, ctx.offer_price)
    bundle.counters.each {|offer| expand_position(offer, ctx, ctx.counter_price)}
  end

  def transfer
    ctx            = OpenStruct.new
    ctx.all_offers = [bundle.offer] + bundle.counters

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