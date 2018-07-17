module OfferCmd
  class Cancel < ApplicationCommand

    validate :open_offer

    def initialize(offer)
      @input_offer = Offer.find(offer.to_i)
      opts = {uuid: @input_offer.uuid}
      add_event :offer, Event::OfferCanceled.new(clean_args(opts))
    end

    private

    def open_offer
      return true if @input_offer.is_open?
      errors.add "offer", "must be open"
      return false
    end

    def clean_args(opts)
      cmd_opts(opts).merge(opts)
    end
  end
end
