module BuyBidCmd
  class Create < ApplicationCommand

    attr_subobjects :bid, :user
    attr_delegate_fields :bid, class_name: "Offer::Buy::Bid"
    attr_vdelegate :maturation_date, :bid

    def initialize(args)
      @bid  = Offer::Buy::Bid.new(default_values.merge(args))
      @user = User.find(bid.user_id)
    end

    def event_data
      @bid.attributes
    end

    def transact_before_project
      bid.status = "open"
    end

    private

    def default_values
      {
        status: "open"
      }
    end
  end
end