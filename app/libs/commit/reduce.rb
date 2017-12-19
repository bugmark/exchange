require_relative '../commit'

class Commit::Reduce < Commit

  def generate
    ctx = base_context

    # look up contract
    ctx.contract = bundle.offer.obj.salable_position.contract

    # generate amendment, escrow, price
    gen_connectors(ctx, Amendment::Reduce, Escrow::Reduce)

    # calculate price for offer and counter
    ctx.counter_price = bundle.counters.map {|el| el.obj.price}.min
    ctx.offer_price   = 1.0 - ctx.counter_price

    # generate artifacts
    expand_position(bundle.offer, ctx, ctx.offer_price)  # BUG HERE - NEED TO PAYOUT ...
    bundle.counters.each {|offer| expand_position(offer, ctx, ctx.counter_price)}

    # update escrow value
    ctx.escrow.update_attributes(fixed_value: ctx.escrow.fixed_values, unfixed_value: ctx.escrow.unfixed_values)

    self
  end

end