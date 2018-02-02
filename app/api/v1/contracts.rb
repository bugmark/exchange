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
      get ':uuid', requirements: { uuid: /.*/ } do
        if contract = Contract.find_by_uuid(params[:uuid])
          present(contract, with: Entities::ContractDetail)
        else
          error!("contract uuid not found", 431)
        end
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