module V1
  class Amendments < V1::App

    resource :amendments do

      # ---------- list all amendments ----------
      desc "List all amendments", {
           is_array: true                       ,
           success:  Entities::AmendmentIds
      }
      get do
        present(Amendment.all, with: Entities::AmendmentIds)
      end

      # ---------- show amendment detail ----------
      desc "Show amendment detail", {
        success: Entities::AmendmentDetail
      }
      get ':uuid' do
        if amendment = Amendment.find_by_uuid(params[:uuid])
          present(amendment, with: Entities::AmendmentDetail)
        else
          error!("Not found", 404)
        end
      end
    end
  end
end
