module V1
  class Test < Grape::API

    resource :issues do
      desc "Return all issues"
      get "", :root => :issues do
        Issues.all
      end
    end
  end
end
