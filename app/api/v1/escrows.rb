module V1
  class Escrows < V1::App

    helpers do
      def escrow_details(repo)
        {
          type:  repo.type  ,
          uuid:  repo.uuid
        }
      end
    end

    resource :escrows do
      desc "List all escrows",
           is_array: true ,
           http_codes: [
             { code: 200, message: "Escrow list", model: Entities::EscrowOverview }
           ]
      get do
        Escrow.all.map {|escrow| {uuid: escrow.uuid}}
      end

      desc "Show escrow detail",
           http_codes: [
             { code: 200, message: "Escrow detail", model: Entities::EscrowDetail }
           ]
      get ':uuid', requirements: { uuid: /.*/ } do
        escrow = Escrow.find_by_uuid(params[:uuid])
        escrow ? escrow_details(escrow) : error!("Not found", 404)
      end
    end
  end
end
