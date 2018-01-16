module V1
  class Offers < V1::App

    resource :offers do
      desc "Return all offers"
      get "", :root => :offers do
        Offer.all
      end
    end
  end
end
