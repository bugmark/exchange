module Vtest
  class Test < Grape::API

    resource :issues do
      desc "Return all issues"
      get "", :root => :issues do
        Issue.all
      end
    end

  end
end
