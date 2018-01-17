module V1
  class Offers < V1::App

    helpers do
      def offer_details(repo)
        {
          type:  repo.type  ,
          uuid:  repo.uuid
        }
      end
    end

    resource :offers do
      desc "List all offers",
           is_array: true ,
           http_codes: [
             { code: 200, message: "Offer list", model: Entities::OfferOverview }
           ]
      get do
        Offer.all.map {|offer| {uuid: offer.uuid}}
      end

      desc "Show offer detail",
           http_codes: [
             { code: 200, message: "Offer detail", model: Entities::OfferDetail }
           ]
      get ':uuid', requirements: { uuid: /.*/ } do
        offer = Offer.find_by_uuid(params[:uuid])
        offer ? offer_details(offer) : error!("Not found", 404)
      end
    end
  end
end
