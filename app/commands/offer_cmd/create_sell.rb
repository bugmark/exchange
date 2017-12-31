module OfferCmd
  class CreateSell < ApplicationCommand

    attr_reader :args, :salable_position

    def initialize(position, args)
      @salable_position = position
      @args  = ArgHandler.new(args, self)
        .apply( &:set_price_and_volume  )
        .apply( &:set_offer_type        )
        .apply( &:set_user              )
        .apply( &:set_salable_uuid      )
        .apply( &:set_maturation        )
        .apply( &:set_status            )
        .apply( &:event_opts            )
      add_event :offer, Event::OfferSellCreated.new(@args.to_h)
    end

    class ArgHandler

      attr_reader :args, :caller, :salable_position

      def initialize(args, caller)
        @args             = args.stringify_keys
        @caller           = caller
        @salable_position = caller.salable_position
      end

      def set_price_and_volume
        @args["volume"] = @args["volume"] || salable_position.volume
        @args["price"]  = @args["price"]  || salable_position.price
        self
      end

      def set_offer_type
        @args["type"] = klas
        self
      end

      def set_maturation
        puts("NO SP")     unless salable_position
        puts("NO ESCROW") unless salable_position.escrow
        @args["maturation"] = salable_position.contract.maturation
        self
      end

      def event_opts
        @args = caller.send(:cmd_opts)
                  .merge(@args)
                  .without("deposit", "profit")
                  .merge(salable_position.offer.match_attrs)
                  .stringify_keys
        self
      end

      def set_user
        @args["user_uuid"] = salable_position.user_uuid
        self
      end

      def set_salable_uuid
        @args["salable_position_uuid"] = salable_position.uuid
        self
      end

      def set_status
        @args["status"] = "open"
        self
      end

      def to_h
        @args
      end

      private

      def klas
        case salable_position.side
          when "unfixed" then "Offer::Sell::Unfixed"
          when "fixed"   then "Offer::Sell::Fixed"
          else raise "unknown position side (#{salable_position.side})"
        end
      end
    end

    def sell_offer_params
      time_base = salable_position&.contract&.maturation || BugmTime.now
      range     = time_base-1.week..time_base+1.week
      {
        status:  "open"                            ,
        volume:  @volume                           ,
        price:   @price                            ,
        user:    salable_position.user             ,
        salable_position: salable_position         ,
        maturation_range: range                    ,
      }.merge(salable_position.offer.match_attrs)
    end
  end
end