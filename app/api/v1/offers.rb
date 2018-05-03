require 'ext/hash'
require 'time'

module V1
  class Offers < V1::App

    resource :offers do

      # ---------- list all offers ----------
      desc "List all offer ids", {
        is_array: true ,
        success: Entities::OfferIds
      }
      params do
        optional :with_type   , type: String  , desc: "type filter"
        optional :with_status , type: String  , desc: "status filter"
        optional :limit       , type: Integer , desc: "limit"
      end
      get do
        type   = params[:with_type]
        status = params[:with_status]
        scope = Offer.all
        scope = scope.where("type like ?", "%#{type}%") if type
        scope = scope.where(status: status) if status
        scope = scope.limit(params[:limit]) if params[:limit]
        present(scope.all, with: Entities::OfferIds)
      end

      # ---------- list offer details ----------
      desc "List all offer details", {
        is_array: true ,
        success: Entities::OfferDetail
      }
      params do
        optional :with_type   , type: String  , desc: "type filter"
        optional :with_status , type: String  , desc: "status filter"
        optional :limit       , type: Integer , desc: "limit"
      end
      get '/detail' do
        type   = params[:with_type]
        status = params[:with_status]
        scope = Offer.all
        scope = scope.where("type like ?", "%#{type}%") if type
        scope = scope.where(status: status) if status
        scope = scope.limit(params[:limit]) if params[:limit]
        present(scope.all, with: Entities::OfferDetail)
      end

      # ---------- list offer detail ----------
      desc "Show details for one offer", {
        success: Entities::OfferDetail
      }
      get ':uuid' do
        offer = Offer.find_by_uuid(params[:uuid])
        error!("not found", 404) if offer.nil?
        present(offer, with: Entities::OfferDetail)
      end

      # ---------- create buy offer ----------
      desc "Create a buy offer", {
        success:  Entities::OfferCreated    ,
        consumes: ['multipart/form-data']
      }
      params do
        requires :side              , type: String  , desc: "fixed or unfixed"   , values: %w(fixed unfixed)
        requires :volume            , type: Integer , desc: "number of positions"
        requires :price             , type: Float   , desc: "between 0.0 and 1.0", values: 0.00..1.00
        optional :tracker           , type: String  , desc: "tracker UUID"
        optional :issue             , type: String  , desc: "issue UUID"
        optional :title             , type: String  , desc: "issue title"
        optional :labels            , type: String  , desc: "issue labels"
        optional :status            , type: String  , desc: "issue status", values: %w(open closed)
        optional :maturation        , type: String  , desc: "YYMMDD_HHMM (default now + 1.week)"
        optional :expiration        , type: String  , desc: "YYMMDD_HHMM (default now + 1.day)"
        optional :maturation_offset , type: String  , desc: "offset string (see long description)"
        optional :expiration_offset , type: String  , desc: "offset string (see long description)"
        optional :poolable          , type: Boolean , desc: "poolable? (default false)"   , default: false
        optional :aon               , type: Boolean , desc: "all-or-none? (default false)", default: false
      end
      post '/buy' do
        side  = case params[:side]
          when "fixed" then :offer_bf
          when "unfixed" then :offer_bu
          else "NA"
        end
        moff  = params[:maturation_offset]
        matur = case
          when params[:maturation] then Time.parse(params[:maturation])
          when moff then BugmTime.offset_eval(moff)
          else BugmTime.now + 1.week
        end
        eoff = params[:expiration_offset]
        expir = case
          when params[:expiration] then Time.parse(params[:expiration])
          when eoff then BugmTime.offset_eval(eoff)
          else BugmTime.now + 1.day
        end
        expir = matur if expir > matur
        opts  = {
          user_uuid:         current_user.uuid           ,
          price:             params[:price]              ,
          volume:            params[:volume]             ,
          stm_tracker_uuid:  params[:tracker]            ,
          stm_issue_uuid:    params[:issue]              ,
          stm_title:         params[:title]              ,
          stm_labels:        params[:labels]             ,
          stm_status:        params[:status]             ,
          poolable:          params[:poolable] || false  ,
          aon:               params[:aon] || false       ,
          maturation:        matur                       ,
          expiration:        expir
        }.without_blanks
        cmd = OfferCmd::CreateBuy.new(side, opts)
        if cmd.valid?
          result = cmd.project
          {status: "OK", event_uuid: result.events[:offer].event_uuid, offer_uuid: result.offer.uuid}
        else
          # binding.pry
          error!({status: "ERROR", message: "INVALID OFFER"}, 404)
        end
      end

      # ---------- create clone ----------
      desc "Create a clone", {
        success:  Entities::OfferCreated    ,
        consumes: ['multipart/form-data']
      }
      params do
        optional :volume            , type: Integer , desc: "number of positions"
        optional :price             , type: Float   , desc: "between 0.0 and 1.0", values: 0.00..1.00
        optional :tracker              , type: String  , desc: "tracker UUID"
        optional :issue             , type: String  , desc: "issue UUID"
        optional :title             , type: String  , desc: "issue title"
        optional :labels            , type: String  , desc: "issue labels"
        optional :status            , type: String  , desc: "issue status", values: %w(open closed)
        optional :maturation        , type: String  , desc: "YYMMDD_HHMM (default now + 1.week)"
        optional :expiration        , type: String  , desc: "YYMMDD_HHMM (default now + 1.day)"
        optional :maturation_offset , type: String  , desc: "offset string (see long description)"
        optional :expiration_offset , type: String  , desc: "offset string (see long description)"
        optional :poolable          , type: Boolean , desc: "poolable? (default false)"
        optional :aon               , type: Boolean , desc: "all-or-none? (default false)"
      end
      post ':uuid/clone' do
        # moff  = params[:maturation_offset]
        # matur = case
        #   when params[:maturation] then Time.parse(params[:maturation])
        #   when moff then BugmTime.offset_eval(moff)
        #   else nil
        # end
        # eoff = params[:expiration_offset]
        # expir = case
        #   when params[:expiration] then Time.parse(params[:expiration])
        #   when eoff then BugmTime.offset_eval(eoff)
        #   else nil
        # end
        # binding.pry
        # expir = matur if expir > matur
        opts  = {
          user_uuid:      current_user.uuid ,
          price:          params[:price]    ,
          volume:         params[:volume]   ,
          stm_tracker_uuid:  params[:tracker]     ,
          stm_issue_uuid: params[:issue]    ,
          stm_title:      params[:title]    ,
          stm_labels:     params[:labels]   ,
          stm_status:     params[:status]   ,
          poolable:       params[:poolable] ,
          aon:            params[:aon]      ,
          # maturation:     matur             ,
          # expiration:     expir
        }.without_blanks
        proto = Offer.find_by_uuid(params[:uuid])
        cmd   = OfferCmd::CreateClone.new(proto, opts)
        if cmd.valid?
          result = cmd.project
          {status: "OK", event_uuid: result.events[:offer].event_uuid, offer_uuid: result.offer.uuid}
        else
          error!({status: "ERROR", message: "INVALID OFFER"}, 404)
        end
      end

      # ---------- create counter ----------
      desc "Create a counter-offer", {
        success:  Entities::OfferCreated    ,
        consumes: ['multipart/form-data']
      }
      post ':uuid/counter' do
        opts  = {
          user_uuid:      current_user.uuid ,
        }.without_blanks
        proto = Offer.find_by_uuid(params[:uuid])
        cmd = OfferCmd::CreateCounter.new(proto, opts)
        if cmd.valid?
          result = cmd.project
          {status: "OK", event_uuid: result.events[:offer].event_uuid, offer_uuid: result.offer.uuid}
        else
          error!({status: "ERROR", message: "INVALID OFFER"}, 404)
        end
      end

      # ---------- cancel offer ----------
      desc "Cancel offer", {
        success: Entities::OfferDetail
      }
      put ':uuid/cancel' do
        offer = Offer.find_by_uuid(params[:uuid])
        cmd = OfferCmd::Cancel.new(offer)
        if cmd.valid?
          cmd.project
          offer.reload
          present(offer, with: Entities::OfferDetail)
        else
          msg = cmd.errors.messages.values.join(", ")
          error!({status: "ERROR", message: msg}, 404)
        end
      end
    end
  end
end
