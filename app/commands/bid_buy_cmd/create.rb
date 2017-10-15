module BidBuyCmd
  class Create < ApplicationCommand

    attr_subobjects :bid, :user
    attr_delegate_fields :bid, class_name: "Offer::Buy::Bid"
    attr_vdelegate :maturation_date, :bid

    def initialize(args)
      @bid  = Offer::Buy::Bid.new(args)
      @user = User.find(bid.user_id)
    end

    def event_data
      @bid.attributes
    end

    def transact_before_project
      bid.status = "open"
      # user.token_balance -= bid.token_value
    end

  end
end
