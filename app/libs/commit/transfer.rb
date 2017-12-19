require_relative '../commit'

class Commit::Transfer < Commit

  def generate
    ctx = base_context

    # look up contract
    # ctx.contract = bundle.offer.obj.salable_position.contract

    # generate amendment & escrow
    gen_connectors(ctx, Amendment::Transfer, Escrow::Transfer)

    # calculate price for offer and counters
    clist             = bundle.counters.map {|el| el.obj.price}
    cprice            = bundle.offer.obj.is_sell? ? clist.max : clist.min
    oprice            = bundle.offer.obj.price
    ctx.counter_price = [oprice, cprice].avg.round(2)
    ctx.offer_price   = ctx.counter_price

    # generate artifacts
    expand_position(bundle.offer, ctx, ctx.offer_price)
    bundle.counters.each {|offer| expand_position(offer, ctx, ctx.counter_price)}

    # update escrow value
    ctx.escrow.update_attributes(fixed_value: ctx.escrow.fixed_values, unfixed_value: ctx.escrow.unfixed_values)

    self
  end

end