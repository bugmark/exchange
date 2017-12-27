# integration_test: commands/contract_cmd/cross/transfer

require_relative '../commit'

class Commit::Transfer < Commit

  def generate
    ctx = base_context

    # look up contract
    # ctx.c_contract = bundle.offer.obj.salable_position.c_contract

    # generate amendment & escrow
    gen_escrow_and_amendment(ctx, Amendment::Transfer, Escrow::Transfer)

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
    ctx = update_escrow_value(ctx)

    # return self
    self
  end

end