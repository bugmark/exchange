module V1
  class Escrows < V1::App

    resource :escrows do

      # ---------- list all escrows ----------
      desc "List all escrows", {
        is_array: true                       ,
        success:  Entities::EscrowIds
      }
      get do
        present(Escrow.all, with: Entities::EscrowIds)
      end

      # ---------- show escrow detail ----------
      desc "Show escrow detail", {
        success: Entities::EscrowDetail
      }
      get ':uuid' do
        if escrow = Escrow.find_by_uuid(params[:uuid])
          present(escrow, with: Entities::EscrowDetail)
        else
          error!("Not found", 404)
        end
      end
    end
  end
end

