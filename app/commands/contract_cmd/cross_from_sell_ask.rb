module ContractCmd
  class CrossFromSellAsk < ApplicationCommand

    # attr_subobjects :transfer, :ask, :bid
    # attr_delegate_fields :transfer

    validate :cross_integrity

    def initialize(ask_param, contract_opts = {})
      @ask      = Offer::Sell::Ask.unassigned.find(ask_param.to_i)
      @transfer = String.new # Amendment::Transfer.new
      @bid      = gen_cross(ask).first
    end

    def transact_before_project
      bpos = Position.create(parent: ask.parent_position, volume: ask.volume, price: ask.price, user: bid.user)
      # TODO: create a seller position
      transfer.update_attributes(transfer_opts(bpos))
      bid.update_attribute :status, 'crossed'
      ask.update_attribute :status, 'crossed'
      bid.user.increment(bid.value).save
      ask.user.decrement(bid.value).save
    end

    private

    def gen_cross(ask)
      return [] unless ask.present?
      bids = Offer::Buy::Bid.open.matches(ask).equals(ask).with_volume(ask.volume)
      if bids.count > 0
        bid = bids.first
        [bid]
      else
        []
      end
    end

    def transfer_opts(spos)
      {
        sell_offer:      ask,
        buy_offer:       bid,
        parent_position: ask.parent_position,
        buyer_position:  bpos,
        # buyer_position_id:  "TBD"
      }
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
