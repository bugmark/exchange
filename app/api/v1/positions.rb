module V1
  class Positions < V1::App

    resource :positions do
      desc "Return all positions"
      get "", :root => :positions do
        Position.all
      end
    end
  end
end
