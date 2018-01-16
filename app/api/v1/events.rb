module V1
  class Events < V1::App

    resource :events do
      desc "Return events",
           is_array: true   ,
           http_codes: [
             { code: 200, message: "Event list", model: Entities::Event}
         ]
      params do
        optional :after, type: Integer, desc: "<cursor> an event-ID", documentation: { example: 10 }
      end
      get do
        if params[:after]
          Event.where('id > ?', params[:after])
        else
          Event.all
        end
      end

      desc "Update an event"
      params do
        requires :id           , type: Integer
        requires :etherscan_url, type: String
      end
      put "", :root => :events do
        el = Event.find(params[:id])
        el.update_attribute(:etherscan_url, params[:etherscan_url])
      end
    end
  end
end
