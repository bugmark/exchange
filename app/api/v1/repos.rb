module V1
  class Repos < V1::App

    resource :repos do
      desc "Return all repos"
      get "", :root => :repos do
        Repo.all
      end
    end
  end
end
