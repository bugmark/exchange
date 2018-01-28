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
        requires :side       , type: String    , desc: "fixed or unfixed", values: %w(fixed unfixed)
        requires :volume     , type: Integer   , desc: "number of positions", values: ->(x){x > 0}
        requires :price      , type: Float     , desc: "between 0.0 and 1.0", values: 0.00..1.00
        requires :issue      , type: String    , desc: "issue UUID"
        optional :maturation , type: String    , desc: "YYMMDD_HHMM (default now + 1.week)"
        optional :expiration , type: String    , desc: "YYMMDD_HHMM (default now + 1.day)"
        optional :poolable   , type: Boolean   , desc: "poolable? (default false)"   , default: false
        optional :aon        , type: Boolean   , desc: "all-or-none? (default false)", default: false
      end
      post '/buy' do
        side = case params[:side]
                 when "fixed" then :offer_bf
                 when "unfixed" then :offer_bu
                 else "NA"
               end
        opts = {
          price:          0.00       ,
          volume:         10         ,
          user_uuid:      "TBD"      ,
          stm_issue_uuid: "TBD"      ,
          stm_status:     "closed"   ,
          poolable:       false      ,
          aon:            false      ,
          maturation:     Time.now + 1.week ,
          expiration:     Time.now + 1.day
        }
        cmd = OfferCmd::CreateBuy.new(side, opts)
        if cmd.valid?
          result = cmd.project
          {status: "OK", event_uuid: result.events[:offer].event_uuid, offer_uuid: result.offer.uuid}
        else
          error!({status: "ERROR", message: "INVALID OFFER"}, 404)
        end
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
