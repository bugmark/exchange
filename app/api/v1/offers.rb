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
      desc "Create a buy offer",
           http_codes: [
                         { code: 200, message: "Outcome", model: Entities::Status}
                       ],
           consumes: ['multipart/form-data']
      params do
        requires :side       , type: String    , desc: "fixed or unfixed"
        requires :volume     , type: Integer   , desc: "number of positions"
        requires :price      , type: Float     , desc: "between 0.0 and 1.0"
        requires :issue      , type: String    , desc: "issue UUID"
        optional :maturation , type: String    , desc: "YYMMDD_HHMM (default now + 1.week)"
        optional :expiration , type: String    , desc: "YYMMDD_HHMM (default now + 1.day)"
        optional :aon        , type: Boolean   , desc: "all-or-none (default false)"
      end
      post '/buy' do
        # opts    = { email: params[:usermail], password: params[:password] }
        # command = UserCmd::Create.new(opts)
        # if command.valid?
        #   command.project
        #   {status: "OK"}
        # else
        #   {status: "Error", message: command.errors.messages.to_s}
        # end
        {status: "OK"}
      end

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
