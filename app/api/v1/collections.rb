module V1
  class Collections < Grape::API

    resource :repos do
      desc "Return all repos"
      get "", :root => :repos do
        Repo.all
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
  end
end
