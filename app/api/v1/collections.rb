module V1
  class Collections < V1::App

    resource :rebuild_date do
      desc "Return the system rebuild time"
      get "", :root => :rebuild_date do
        fn = "/tmp/bugm_build_date.txt"
        File.exist?(fn) ? File.read(fn).strip : ""
      end
    end

    resource :positions do
      desc "Return all positions"
      get "", :root => :positions do
        Position.all
      end
    end
  end
end
