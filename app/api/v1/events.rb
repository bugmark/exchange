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

      desc "Show event record",
           http_codes: [
                         { code: 200, message: "Event detail", model: Entities::Event }
                       ]
      get ':event_uuid', requirements: { event_uuid: /.*/ } do
        event = Event.find_by_event_uuid(params[:event_uuid])
        event ? event : error!("Not found", 404)
      end

      desc "Update an event",
           consumes: ['multipart/form-data']
      params do
        requires :id           , type: Integer
        requires :etherscan_url, type: String
      end
      put do
        el = Event.find(params[:id])
        el.update_attribute(:etherscan_url, params[:etherscan_url])
      end
    end
  end
end
