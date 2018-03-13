require 'ext/hash'

module V1
  class Contracts < V1::App

    resource :contract do

      # ---------- list all contracts ----------
      desc "List all contracts", {
        is_array:   true ,
        success: Entities::ContractOverview
      }
      get do
        present Contract.open, with: Entities::ContractOverview
      end

      # ---------- show contract detail ----------
      desc "Show contract detail", {
        success: Entities::ContractDetail         ,
        failure: [[431, "CONTRACT UUID NOT FOUND"]]
      }
      get ':uuid' do
        if contract = Contract.find_by_uuid(params[:uuid])
          present(contract, with: Entities::ContractDetail)
        else
          error!("contract uuid not found", 431)
        end
      end

      # ---------- show contract escrows ----------
      desc "Show contract escrows", {
        is_array: true                                  ,
        success:  Entities::EscrowDetail                ,
        failure: [[431, "CONTRACT UUID NOT FOUND"]]
      }
      get ':uuid/escrows' do
        contract = Contract.find_by_uuid(params[:uuid])
        error!("contract UUID not found", 431) if contract.nil?
        present(contract.escrows, with: Entities::EscrowDetail)
      end

      # ---------- show contract amendments ----------
      desc "Show contract amendments", {
        is_array: true                                     ,
        success:  Entities::AmendmentDetail                ,
        failure: [[431, "CONTRACT UUID NOT FOUND"]]
      }
      get ':uuid/amendments' do
        contract = Contract.find_by_uuid(params[:uuid])
        error!("contract UUID not found", 431) if contract.nil?
        present(contract.amendments, with: Entities::AmendmentDetail)
      end

      # ---------- show contract positions ----------
      desc "Show contract positions", {
        is_array: true                                  ,
        success:  Entities::PositionDetail                ,
        failure: [[431, "CONTRACT UUID NOT FOUND"]]
      }
      get ':uuid/positions' do
        contract = Contract.find_by_uuid(params[:uuid])
        error!("contract UUID not found", 431) if contract.nil?
        present(contract.positions, with: Entities::PositionDetail)
      end

      # ---------- show contract open_offers ----------
      desc "Show contract open_offers", {
        is_array: true                                  ,
        success:  Entities::OfferDetail                 ,
        failure:  [[431, "CONTRACT UUID NOT FOUND"]]
      }
      get ':uuid/open_offers' do
        contract = Contract.find_by_uuid(params[:uuid])
        error!("contract UUID not found", 431) if contract.nil?
        scope = contract.match_offers.open.by_overlap_maturation(contract.maturation)
        present(scope, with: Entities::OfferDetail)
      end

      # ---------- show contract series ----------
      # desc "Show contract series", {
      #   success: Entities::Status                        ,
      #   failure: [[431, "CONTRACT UUID NOT FOUND"]]
      # }
      # get ':uuid/series' do
      #   present({status: "OK", message: "UNDER CONSTRUCTION"}, with: Entities::Status)
      # end

      # ---------- create contract ----------
      desc "Create contract", {
        success:  Entities::ContractStatus    ,
        consumes: ['multipart/form-data']
      }
      params do
        optional :issue      , type: String  , desc: "issue UUID"
        optional :repo       , type: String  , desc: "repo UUID"
        optional :title      , type: String  , desc: "title"
        optional :status     , type: String  , desc: "status"
        optional :labels     , type: String  , desc: "labels"
        optional :maturation , type: String  , desc: "YYMMDD_HHMM (default now + 1.week)"
      end
      post '/create' do
        matur = params[:maturation] ? Time.parse(params[:maturation]) : BugmTime.now + 1.week
        opts = {
          uuid:           SecureRandom.uuid          ,
          stm_issue_uuid: params[:issue]             ,
          stm_repo_uuid:  params[:repo]              ,
          stm_title:      params[:title]             ,
          stm_status:     params[:status]            ,
          stm_labels:     params[:labels]            ,
          maturation:     matur                      ,
        }.without_blanks
        cmd = ContractCmd::Create.new(opts)
        if cmd.valid?
          result = cmd.project
          eu = result.events[:contract].event_uuid
          cu = result.contract.uuid
          cs = result.contract.status
          {status: "OK", event_uuid: eu, contract_uuid: cu, contract_status: cs}
        else
          msg = cmd.errors.messages.map {|k, v| "#{k}: #{v.join(", ")}"}.join(" | ")
          error!({status: "ERROR", message: msg}, 404)
        end
      end

      # ---------- clone contract ----------
      desc "Clone contract", {
        success:  Entities::ContractStatus    ,
        consumes: ['multipart/form-data']
      }
      params do
        optional :issue      , type: String  , desc: "issue UUID"
        optional :repo       , type: String  , desc: "repo UUID"
        optional :title      , type: String  , desc: "title"
        optional :status     , type: String  , desc: "status"
        optional :labels     , type: String  , desc: "labels"
        optional :maturation , type: String  , desc: "YYMMDD_HHMM (default now + 1.week)"
      end
      post ':contract_uuid/clone' do
        matur = params[:maturation] ? Time.parse(params[:maturation]) : BugmTime.now + 1.week
        opts = {
          uuid:           SecureRandom.uuid          ,
          stm_issue_uuid: params[:issue]             ,
          stm_repo_uuid:  params[:repo]              ,
          stm_title:      params[:title]             ,
          stm_status:     params[:status]            ,
          stm_labels:     params[:labels]            ,
          maturation:     matur                      ,
        }.without_blanks
        cuuid    = params[:contract_uuid]
        contract = Contract.find_by_uuid(cuuid)
        pkg      = {status: "ERROR", message: "contract not found (#{cuuid})"}
        error!(pkg, 404) unless contract
        cmd = ContractCmd::Clone.new(contract, opts)
        if cmd.valid?
          result = cmd.project
          eu = result.events[:clone].event_uuid
          cu = result.clone.uuid
          cs = result.contract.status
          {status: "OK", event_uuid: eu, contract_uuid: cu, contract_status: cs}
        else
          msg = cmd.errors.messages.map {|k, v| "#{k}: #{v.join(", ")}"}.join(" | ")
          error!({status: "ERROR", message: msg}, 404)
        end
      end

      # ---------- cancel contract ----------
      desc "Cancel contract", {
        success:  Entities::ContractStatus    ,
        consumes: ['multipart/form-data']
      }
      post ':contract_uuid/cancel' do
        cuuid    = params[:contract_uuid]
        contract = Contract.find_by_uuid(cuuid)
        pkg      = {status: "ERROR", message: "contract not found (#{cuuid})"}
        error!(pkg, 404) unless contract
        cmd = ContractCmd::Cancel.new(contract)
        if cmd.valid?
          result = cmd.project
          eu = result.events[:contract].event_uuid
          cu = result.contract.uuid
          cs = result.contract.status
          {status: "OK", event_uuid: eu, contract_uuid: cu, contract_status: cs}
        else
          msg = cmd.errors.messages.map {|k, v| "#{k}: #{v.join(", ")}"}.join(" | ")
          error!({status: "ERROR", message: msg}, 404)
        end
      end

      # ---------- cross offer ----------
      desc "Cross offer", {
        success:    Entities::ContractStatus   ,
        failure:    [[404, "INVALID OFFER"]]   ,
        consumes:   ['multipart/form-data']
      }
      params do
        requires :commit_type , type: String , desc: "expand, transfer or reduce", values: %w(expand transfer reduce)
      end
      post ':offer_uuid/cross' do
        offer = Offer.find_by_uuid(params[:offer_uuid])
        cmd   = ContractCmd::Cross.new(offer, params[:commit_type].to_sym)
        if cmd.valid?
          result = cmd.project
          eu = result.events.first[1].event_uuid
          cu = result.contract.uuid
          cs = result.contract.status
          {status: "OK", event_uuid: eu, contract_uuid: cu, contract_status: cs}
        else
          msg = cmd.errors.messages.map {|k, v| "#{k}:#{v}"}.join(" | ")
          error!(msg, 404)
        end
      end

      # ---------- resolve contract ----------
      desc "Resolve contract", {
        success:    Entities::ContractStatus    ,
        failure:    [[404, "INVALID OFFER"]]    ,
        consumes:   ['multipart/form-data']
      }
      put ':uuid/resolve' do
        uuid = params[:uuid]
        contract = Contract.find_by_uuid(uuid)
        error!("contract not found (#{uuid}", 404) if contract.nil?
        cmd   = ContractCmd::Resolve.new(contract)
        if cmd.valid?
          result = cmd.project
          eu = result.events[:contract].event_uuid
          cu = result.contract.uuid
          cs = result.contract.status
          {status: "OK", event_uuid: eu, contract_uuid: cu, contract_status: cs}
        else
          error!(cmd.errors.messages.values.join(" | "), 404)
        end
      end

    end
  end
end