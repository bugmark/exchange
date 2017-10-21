module ContractCmd
  class CrossFromBuyAsk < ApplicationCommand

    attr_subobjects :offer, :counters, :commit_type
    attr_delegate_fields :src_offer

    validate :cross_integrity

    def initialize(offer, commit_type)
      @offer    = Offer.find(offer.to_i)
      @counters = @offer.qualified_counteroffers
      # @qualified = @src_offer.match_contracts.first || Contract.new(contract_opts)
      # @escrow   = Escrow.new
      # = gen_cross(ask).first
    end

    def transact_before_project
      # TODO: pick best-fit maturation date
      contract.assign_attributes(ask.match_attrs)
      contract.maturation = ask.maturation
      contract.save
      escrow.assign_attributes(contract: contract, bid_value: bid.value, ask_value: ask.value)
      escrow.save
      # TODO: pick best-fit price
      Position.create(volume: bid.volume, price: bid.price, user: bid.user, buy_offer: bid, escrow: escrow, side: 'bid')
      Position.create(volume: ask.volume, price: ask.price, user: ask.user, buy_offer: ask, escrow: escrow, side: 'ask')
      bid.update_attribute :status, 'crossed'
      ask.update_attribute :status, 'crossed'
      bid.user.decrement(bid.value).save
      ask.user.decrement(bid.value).save
    end

    private

    def gen_cross(ask)
      # TODO: enable partial crosses, multi-party crosses
      return [] unless counter.present?
      bids = Offer::Buy::Bid.with_status('open').matches(ask).complements(ask).with_volume(ask.volume)
      if bids.count > 0
        bid = bids.first
        [bid]
      else
        []
      end
    end

    def cross_integrity
      if @bid.nil?
        errors.add :id, "no crosses found"
      end
      if @ask.nil?
        errors.add :id, "invalid ask"
      end
    end
  end
end
