module V1
  class Positions < V1::App

    resource :positions do

      # ---------- list all positions ----------
      desc "List all positions", {
           is_array: true                       ,
           success:  Entities::PositionOverview
      }
      get do
        present(Position.all, with: Entities::PositionOverview)
      end

      # ---------- show position detail ----------
      desc "Show position detail", {
        success: Entities::PositionDetail
      }
      get ':uuid' do
        if position = Position.find_by_uuid(params[:uuid])
          present(position, with: Entities::PositionDetail)
        else
          error!("Not found", 404)
        end
      end
    end
  end
end
