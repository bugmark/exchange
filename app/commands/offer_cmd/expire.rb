module OfferCmd
  class Expire < ApplicationCommand

    validate :open_offer
    validate :past_expiration

    def initialize(offer)
      @input_offer = Offer.find(offer.to_i)
      opts = {uuid: @input_offer.uuid}
      add_event :offer, Event::OfferExpired.new(clean_args(opts))
    end

    private

    def open_offer
      return true if @input_offer.is_open?
      errors.add "offer", "must be open"
      return false
    end

    def past_expiration
      return true if BugmTime.now > @input_offer.expiration
      errors.add "offer", "has not reached expiration"
      return false
    end

    def clean_args(opts)
      cmd_opts(opts).merge(opts)
    end
  end
end
