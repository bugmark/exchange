module V1
  class Positions < V1::App
    helpers do
      def position_details(repo)
        {
          type:  repo.type  ,
          uuid:  repo.uuid
        }
      end
    end

    resource :positions do
      desc "List all positions",
           is_array: true ,
           http_codes: [
             { code: 200, message: "Position list", model: Entities::PositionOverview }
           ]
      get do
        Position.all.map {|position| {uuid: position.uuid}}
      end

      desc "Show position detail",
           http_codes: [
             { code: 200, message: "Position detail", model: Entities::PositionDetail }
           ]
      get ':uuid', requirements: { uuid: /.*/ } do
        position = Position.find_by_uuid(params[:uuid])
        position ? position_details(position) : error!("Not found", 404)
      end
    end
  end
end
