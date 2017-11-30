require 'ostruct'

module OfferCmd
  class CloneBuy

    attr_reader :offer, :command

    delegate :project, :valid?, :errors, :to => :command

    def initialize(offer, new_attrs)
      @offer   = Offer.find(offer.to_i)
      @command = cmd_obj(valid_attrs(new_attrs))
    end

    private

    def cmd_obj(attrs)
      if offer.is_buy?
        OfferCmd::CreateBuy.new(offer.cmd_type, attrs)
      else
        opts = {
          project:    false,
          valid?:     false,
          errors:     {
            messages: ["must be a buy offer"]
          }
        }
        OpenStruct.new opts
      end
    end

    def valid_attrs(new_attrs)
      alt  = {prototype_id: offer.id, status: "open"}
      offer.attributes.except(:id, "id").merge(alt).merge(new_attrs)
    end
  end
end

