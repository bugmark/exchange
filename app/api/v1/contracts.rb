module V1
  class Contracts < V1::App

    helpers do
      def contract_details(repo)
        {
          type:  repo.type  ,
          uuid:  repo.uuid
        }
      end
    end

    resource :contracts do
      desc "List all contracts",
           is_array: true ,
           http_codes: [
             { code: 200, message: "Contract list", model: Entities::ContractOverview }
           ]
      get do
        Contract.all.map {|contract| {uuid: contract.uuid}}
      end

      desc "Show contract detail",
           http_codes: [
             { code: 200, message: "Contract detail", model: Entities::ContractDetail }
           ]
      get ':uuid', requirements: { uuid: /.*/ } do
        contract = Contract.find_by_uuid(params[:uuid])
        contract ? contract_details(contract) : error!("Not found", 404)
      end
    end
  end
end
