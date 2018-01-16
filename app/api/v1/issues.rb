module V1
  class Issues < V1::App

    resource :issues do
      desc "Return all bugs"
      get "", :root => :issues do
        Issue.all
      end
    end
  end
end
