#-integration_test: commands/contract_cmd/cross/expand
# integration_test: commands/contract_cmd/cross/transfer
# integration_test: commands/contract_cmd/cross/reduce

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

  def base_context
    ctx            = OpenStruct.new
    ctx.all_offers = [bundle.offer] + bundle.counters
    ctx.max_start  = ctx.all_offers.map {|o| o.obj.maturation_range.begin}.max
    ctx.min_end    = ctx.all_offers.map {|o| o.obj.maturation_range.end}.min
    ctx
  end

  def gen_connectors(ctx, amendment_klas, escrow_klas)
    ctx.amendment = amendment_klas.create(contract: ctx.contract)
    ctx.escrow    = escrow_klas.create(contract: ctx.contract, amendment: ctx.amendment)
  end

  def expand_position(offer, ctx, price)
    posargs = {
      volume:     offer.vol         ,
      price:      price             ,
      amendment:  ctx.amendment     ,
      escrow:     ctx.escrow        ,
      offer:      offer.obj         ,
      user:       offer.obj.user    ,
    }
    lcl_pos = Position.create(posargs)
    # TODO
    # [x]refund release - happens when offer status is changed
    # [x]generate reoffer - not going to do that now
    # [x]capture escrow - update user balance
    new_balance = offer.obj.user.balance - lcl_pos.value
    offer.obj.user.update_attribute(:balance, new_balance)
    offer.obj.update_attribute(:status, 'crossed')
  end

  def expand
    ctx = base_context

    # find or generate contract
    ctx.matching  = bundle.offer.obj.match_contracts.overlap(ctx.max_start, ctx.min_end)
    ctx.selected  = ctx.matching.sort_by {|c| c.escrows.count}.first
    # binding.pry
    ctx.contract  = @contract = ctx.selected || begin
      date = [ctx.max_start, ctx.min_end].avg_time
      attr = bundle.offer.obj.match_attrs.merge(maturation: date)
      Contract.create(attr)
    end

    # generate amendment and escrow
    gen_connectors(ctx, Amendment::Expand, Escrow::Expand)

    # calculate price for offer and counter
    ctx.counter_price = bundle.counters.map {|el| el.obj.price}.min
    ctx.offer_price   = 1.0 - ctx.counter_price

    # generate artifacts
    expand_position(bundle.offer, ctx, ctx.offer_price)
    bundle.counters.each {|offer| expand_position(offer, ctx, ctx.counter_price)}

    # update escrow value
    ctx.escrow.update_attributes(bid_value: ctx.escrow.bid_values, ask_value: ctx.escrow.ask_values)
  end

  def transfer
    ctx = base_context

    # look up contract
    ctx.contract = bundle.offer.obj.parent_position.contract

    # generate amendment & escrow
    gen_connectors(ctx, Amendment::Transfer, Escrow::Transfer)

    # calculate price for offer and counters
    ctx.counter_price = bundle.counters.map {|el| el.obj.price}.min
    ctx.offer_price   = 1.0 - ctx.counter_price

    # generate artifacts
    expand_position(bundle.offer, ctx, ctx.offer_price)
    bundle.counters.each {|offer| expand_position(offer, ctx, ctx.counter_price)}

    # update escrow value
    ctx.escrow.update_attributes(bid_value: ctx.escrow.bid_values, ask_value: ctx.escrow.ask_values)
  end

  def reduce
    ctx = base_context

    # look up contract
    ctx.contract = bundle.offer.obj.parent_position.contract

    # generate amendment, escrow, price
    gen_connectors(ctx, Amendment::Reduce, Escrow::Reduce)

    # calculate price for offer and counter
    ctx.counter_price = bundle.counters.map {|el| el.obj.price}.min
    ctx.offer_price   = 1.0 - ctx.counter_price

    # generate artifacts
    expand_position(bundle.offer, ctx, ctx.offer_price)
    bundle.counters.each {|offer| expand_position(offer, ctx, ctx.counter_price)}

    # update escrow value
    ctx.escrow.update_attributes(bid_value: ctx.escrow.bid_values, ask_value: ctx.escrow.ask_values)
  end
end