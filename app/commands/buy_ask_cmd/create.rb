module BuyAskCmd
  class Create < ApplicationCommand

    attr_subobjects :ask, :user
    attr_delegate_fields :ask, class_name: "Offer::Buy::Ask"
    attr_vdelegate :maturation_date, :ask

    def initialize(args)
      @ask  = Offer::Buy::Ask.new(args)
      @user = User.find(ask.user_id)
    end

    def event_data
      @ask.attributes
    end

    def transact_before_project
      ask.status = "open"
    end
  end
end
