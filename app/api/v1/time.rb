module V1
  class Time < V1::App

    resource :time do
      desc "current exchange time",
           http_codes: [
             { code: 200, message: "Time", model: Entities::TimeNow}
           ]
      get "/now" do
        {
          bugmark_time: BugmTime.now.to_s    ,
          day_offset:   BugmTime.day_offset
        }
      end

      desc "future week-ends",
           is_array: true,
           http_codes: [
             { code: 200, message: "Time", model: Entities::TimeWeekEnds}
           ]
      params do
        optional :count, type: Integer, desc: "count (default 4)"
      end
      get "/future_week_ends" do
        BugmTime.future_week_ends(params[:count] || 4).map do |str|
          {week_end: str}
        end
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

      desc "system rebuild real-time"
      get "/rebuild_date" do
        fn = "/tmp/bugm_build_date.txt"
        File.exist?(fn) ? File.read(fn).strip : ""
      end

    end
  end
end
