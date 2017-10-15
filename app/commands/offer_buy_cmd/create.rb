module OfferBuyCmd
  class Create < ApplicationCommand

    attr_subobjects :ask, :user
    attr_delegate_fields :ask, class_name: "Offer::Ask::Buy"
    attr_vdelegate :maturation_date, :ask

    validate :user_funds

    def initialize(args)
      @ask  = Offer::Ask::Buy.new(args)
      @user = User.find(ask.user_id)
    end

    def event_data
      @ask.attributes
    end

    def transact_before_project
      # user.token_balance -= ask.token_value
    end

    private

    def user_funds
      # if user.token_balance < ask.token_value
      #   errors.add(:token_value, "not enough funds in user account")
      # end
    end
  end
end
