module ContractCmd
  class CrossFromSellAsk < ApplicationCommand

    attr_subobjects :contract, :ask, :escrow, :bid
    attr_delegate_fields :contract

    validate :cross_integrity

    def initialize(ask_param, contract_opts = {})
      @ask      = Offer::Buy::Ask.unassigned.find(ask_param.to_i)
      @contract = @ask.match_contracts.first || Contract.new(contract_opts)
      @escrow   = Escrow.new
      @bid      = gen_cross(ask).first
    end

    def transact_before_project
      contract.save
      escrow.assign_attributes(bid_value: bid.value, ask_value: ask.value)
      escrow.set_association.save
      Position.create(volume: bid.volume, price: bid.price, offer_id: bid.id, escrow_id: escrow.id, side: 'bid')
      Position.create(volume: ask.volume, price: ask.price, offer_id: ask.id, escrow_id: escrow.id, side: 'ask')
      bid.update_attribute :status, 'crossed'
      ask.update_attribute :status, 'crossed'
      bid.user.decrement(bid.value).save
      ask.user.decrement(bid.value).save
    end

    private

    def gen_cross(ask)
      return [] unless ask.present?
      bids = Offer::Buy::Bid.not_open.matches(ask).complements(ask).with_volume(ask.volume)
      if bids.count > 0
        bid = bids.first
        contract.assign_attributes(ask.match_attrs)
        contract.price  = ask.price
        contract.volume = ask.volume
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
