module V1
  class Time < V1::App

    resource :time do
      desc "system rebuild real-time"
      get "/rebuild_date" do
        fn = "/tmp/bugm_build_date.txt"
        File.exist?(fn) ? File.read(fn).strip : ""
      end

      desc "current exchange time"
      get "/now" do
        BugmTime.now
      end

      desc "day offset"
      get "/day_offset" do
        BugmTime.day_offset
      end

      desc "future week-ends"
      get "/future_week_ends" do
        "TBD"
      end

      desc "increment day offset"
      put "/increment_days" do
        "OK"
      end
    end
  end
end
