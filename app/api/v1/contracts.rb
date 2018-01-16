module V1
  class Contracts < V1::App

    resource :contracts do
      desc "Return all contracts"
      get "", :root => :contracts do
        Contract.all
      end
    end
  end
end
