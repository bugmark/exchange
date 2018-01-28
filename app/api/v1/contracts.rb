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
        failure: [[404, "CONTRACT UUID NOT FOUND"]]
      }
      get ':uuid', requirements: { uuid: /.*/ } do
        if contract = Contract.find_by_uuid(params[:uuid])
          present(contract, with: Entities::ContractDetail)
        else
          error!("contract uuid not found", 404)
        end
      end

      # ---------- cross offer ----------
      desc "Cross offer", {
        success:    Entities::Status        ,
        consumes:   ['multipart/form-data']
      }
      params do
        requires :commit_type , type: String , desc: "expand, transfer or reduce", values: %w(expand transfer reduce)
      end
      post ':offer_uuid', requirements: { offer_uuid: /.*/ } do
        cmd = OfferCmd::CreateBuy.new(params[:offer_uuid], params[:commit_type])
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
