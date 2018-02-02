module V1
  class Events < V1::App
    resource :events do
      desc "Return events", {
        is_array: true               ,
        success:  Entities::Event
      }
      params do
        optional :after, type: Integer, desc: "<cursor> an event-ID", documentation: { example: 10 }
        optional :limit, type: Integer, desc: "max # of records"    , documentation: { example: 4  }
      end
      get do
        base = Event.all
        base = base.where('id > ?', params[:after]) if params[:after]
        base = base.limit(params[:limit])           if params[:limit]
        base
      end

      desc "Show event record", {
        failure: [[403, "NOT FOUND"]]  ,
        success: Entities::Event
      }
      get ':event_uuid' do
        event = Event.find_by_event_uuid(params[:event_uuid])
        event ? event : error!("not found", 403)
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
