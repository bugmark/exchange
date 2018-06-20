require 'ostruct'
require 'user_balance'

module GroupCmd
  class UserRemove < ApplicationCommand

    include UserBalance

    attr_reader :prototype_offer

    validate :valid_user_balance

    def initialize(prototype_offer, new_args)
      @prototype_offer = Offer.find(prototype_offer.to_i)
      args = counter_args(proto).merge(new_args.stringify_keys)
      add_event :offer, Event::OfferCloned.new(event_opts(args))
    end

    private

    def counter_args(prototype)
      args = prototype.attributes.stringify_keys
      args["uuid"]           = SecureRandom.uuid
      args["prototype_uuid"] = prototype.uuid
      args["type"]           = prototype.counter_class
      args["price"]          = prototype.counter_price
      args["status"]         = "open"
      args["expiration"]     = prototype.expiration
      # args["maturation_beg"] = prototype.maturation_range.first
      # args["maturation_end"] = prototype.maturation_range.last
      excludes = %w(created_at updated_at id salable_position_uuid maturation_range)
      args = args.stringify_keys.without_blanks.without(*excludes)
      args
    end

    def proto
      prototype_offer
    end

    def event_opts(opts)
      exclude = %w(id deposit profit xfields jfields stm_comments stm_xfields stm_jfields created_at updated_at)
      cmd_opts(opts).merge(opts).without(*exclude).without_blanks
    end
  end
end

