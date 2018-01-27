module V1
  class BmxHost < V1::App

    resource :host do
      desc "info",
           http_codes: [
             { code: 200, message: "Time", model: Entities::HostInfo}
           ]
      get "/info" do
        fn = "/tmp/bugm_build_date.txt"
        {
          host_name:   BugmHost.name        ,
          host_time:   BugmTime.now.to_s    ,
          day_offset:  BugmTime.day_offset  ,
          datastore:   BugmHost.datastore   ,
          released_at: File.exist?(fn) ? File.read(fn).strip : "NA"
        }
      end

      desc "increment day offset",
           http_codes: [
                         { code: 200, message: "Outcome", model: Entities::Status}
                       ],
           consumes: ['multipart/form-data']
      params do
        optional :count, type: Integer, desc: "count (default 1)"
      end

      put "/increment_day_offset" do
        BugmTime.increment_day_offset(params[:count] || 1)
        {status: "OK"}
      end

      desc "next week-ends",
           is_array: true,
           http_codes: [
             { code: 200, message: "Time", model: Entities::TimeWeekEnds}
           ]
      params do
        optional :count, type: Integer, desc: "count (default 4)"
      end
      get "/next_week_ends" do
        BugmTime.next_week_ends(params[:count] || 4).map do |str|
          {week_end: str}
        end
      end

      desc "rebuild"
      get "/rebuild" do
        "OK"
      end
    end
  end
end
