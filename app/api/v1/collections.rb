module V1
  class Collections < Grape::API
    resource :repos do
      desc "Return all repos"
      get "", :root => :repos do
        Repo.all
      end
    end

    resource :rebuild_date do
      desc "Return the system rebuild time"
      get "", :root => :rebuild_date do
        fn = "/tmp/bugm_build_date.txt"
        File.exist?(fn) ? File.read(fn).strip : ""
      end
    end

    resource :bugs do
      desc "Return all bugs"
      get "", :root => :bugs do
        Bug.all
      end
    end

    resource :offers do
      desc "Return all offers"
      get "", :root => :offers do
        Offer.all
      end
    end

    resource :contracts do
      desc "Return all contracts"
      get "", :root => :contracts do
        Contract.all
      end
    end

    resource :positions do
      desc "Return all positions"
      get "", :root => :positions do
        Position.all
      end
    end

    resource :amendments do
      desc "Return all amendments"
      get "", :root => :amendments do
        Amendment.all
      end
    end

    resource :events do
      desc "Return events"
      params do
        optional :after, type: Integer, desc: "<cursor> an event-ID", documentation: { example: 10 }
      end
      get "", :root => :events do
        if params[:after]
          EventLine.where('id > ?', params[:after])
        else
          EventLine.all
        end
      end
      params do
        requires :id           , type: Integer
        requires :etherscan_url, type: String
      end
      put "", :root => :events do
        el = EventLine.find(params[:id])
        el.update_attribute(:etherscan_url, params[:etherscan_url])
      end
    end
  end
end
