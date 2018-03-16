require 'ostruct'
require 'user_balance'

module OfferCmd
  class CreateClone < ApplicationCommand

    include UserBalance

    attr_reader :prototype_offer

    validate :valid_user_balance

    def initialize(prototype_offer, new_args)
      @prototype_offer = Offer.find(prototype_offer.to_i)
      args = new_args.stringify_keys
      args = proto.attributes.merge(args).merge({prototype_uuid: proto.uuid})
      # args = set_maturation(args)
      add_event :offer, Event::OfferCloned.new(event_opts(args))
    end

    private

    def proto
      prototype_offer
    end

    def event_opts(opts)
      exclude = %w(id deposit profit xfields maturation_range jfields stm_xfields stm_jfields)
      cmd_opts.merge(opts).without(*exclude).merge({uuid: SecureRandom.uuid})
    end

    def set_maturation(args)
      return args unless args["maturation_range"]
      args["maturation_beg"] = args["maturation_range"].first
      args["maturation_end"] = args["maturation_range"].last
      args.delete("maturation_range")
      args
    end
  end
end

