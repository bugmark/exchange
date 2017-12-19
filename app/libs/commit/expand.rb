require_relative '../commit'

class Commit::Expand < Commit

  def generate
    ctx = base_context

    # find or generate contract with maturation date
    ctx.matching  = bundle.offer.obj.match_contracts.overlap(ctx.max_start, ctx.min_end)
    ctx.selected  = ctx.matching.sort_by {|c| c.escrows.count}.first
    ctx.contract  = @contract = ctx.selected || begin
      date = [ctx.max_start, ctx.min_end].avg_time
      attr = bundle.offer.obj.match_attrs.merge(maturation: date)
      Contract.create(attr)
    end

    # generate amendment and escrow
    ctx = gen_connectors(ctx, Amendment::Expand, Escrow::Expand)

    # calculate price for offer and counter - half-way between the two
    ctx.counter_min   = bundle.counters.map {|el| el.obj.price}.min
    ctx.price_delta   = ((bundle.offer.obj.price - (1.0 - ctx.counter_min)) / 2.0).round(2)
    ctx.counter_price = ctx.counter_min - ctx.price_delta
    ctx.offer_price   = 1.0 - ctx.counter_price

    # generate artifacts
    expand_position(bundle.offer, ctx, ctx.offer_price)
    bundle.counters.each {|offer| expand_position(offer, ctx, ctx.counter_price)}
    suspend_overlimit_offers(bundle)
    generate_reoffers(ctx)

    # update escrow value
    ctx.escrow.update_attributes(fixed_value: ctx.escrow.fixed_values, unfixed_value: ctx.escrow.unfixed_values)

    self
  end


end