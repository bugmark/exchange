module V1
  class Contracts < V1::App

    resource :contract do

      # ---------- list all contracts ----------
      desc "List all contracts", {
        is_array:   true ,
        success: Entities::ContractOverview
      }
      get do
        present Contract.all, with: Entities::ContractOverview
      end

      # ---------- show contract detail ----------
      desc "Show contract detail", {
        success: Entities::ContractDetail         ,
        failure: [[431, "CONTRACT UUID NOT FOUND"]]
      }
      get ':uuid' do
        if contract = Contract.find_by_uuid(params[:uuid])
          present(contract, with: Entities::ContractDetail)
        else
          error!("contract uuid not found", 431)
        end
      end

      # ---------- show contract history ----------
      desc "Show contract escrows", {
        is_array: true                                  ,
        success:  Entities::EscrowDetail                ,
        failure: [[431, "CONTRACT UUID NOT FOUND"]]
      }
      get ':uuid/escrows' do
        contract = Contract.find_by_uuid(params[:uuid])
        error!("contract UUID not found", 431) if contract.nil?
        present(contract.escrows, with: Entities::EscrowDetail)
      end

      # ---------- show contract open_offers ----------
      desc "Show contract open_offers", {
        is_array: true                                  ,
        success:  Entities::OfferDetail                 ,
        failure:  [[431, "CONTRACT UUID NOT FOUND"]]
      }
      get ':uuid/open_offers' do
        contract = Contract.find_by_uuid(params[:uuid])
        error!("contract UUID not found", 431) if contract.nil?
        scope = contract.match_offers.open.by_overlap_maturation(contract.maturation)
        present(scope, with: Entities::OfferDetail)
      end

      # ---------- show contract history ----------
      desc "Show contract series", {
        success: Entities::Status                        ,
        failure: [[431, "CONTRACT UUID NOT FOUND"]]
      }
      get ':uuid/series' do
        present({status: "OK", message: "UNDER CONSTRUCTION"}, with: Entities::Status)
      end

      # ---------- cross offer ----------
      desc "Cross offer", {
        success:    Entities::Status            ,
        failure:    [[404, "INVALID OFFER"]]    ,
        consumes:   ['multipart/form-data']
      }
      params do
        requires :commit_type , type: String , desc: "expand, transfer or reduce", values: %w(expand transfer reduce)
      end
      post ':offer_uuid' do
        offer = Offer.find_by_uuid(params[:offer_uuid])
        cmd   = ContractCmd::Cross.new(offer, params[:commit_type].to_sym)
        if cmd.valid?
          cmd.project
          present({status: "OK"}, with: Entities::Status)
        else
          error!("invalid offer", 404)
        end
      end
    end
  end
end