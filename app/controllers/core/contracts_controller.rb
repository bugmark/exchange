module Core
  class ContractsController < ApplicationController

  layout 'core'

    before_action :authenticate_user!, :except => [:index, :show, :resolve, :chart]

    # stm_issue_uuid (optional)
    def index
      @bug = @tracker = nil
      base_scope = Contract.all
      case
        when stm_issue_uuid = params["stm_issue_uuid"]
          @bug = Issue.find_by_uuid(stm_issue_uuid)
          @contracts = base_scope.where(stm_issue_uuid: stm_issue_uuid)
        when stm_tracker_uuid = params["stm_tracker_uuid"]
          @tracker = Tracker.find_by_uuid(stm_tracker_uuid)
          @contracts = base_scope.where(stm_tracker_uuid: stm_tracker_uuid)
        else
          @contracts = base_scope
      end
    end

    def show
      @contract = Contract.find(params["id"])
    end

    # stm_bug_uud or stm_tracker_uuid
    def new
      @contract = ContractCmd::Publish.new(new_opts(params))
    end

    # id (contract ID)
    def edit
      @contract = ContractCmd::Take.find(params[:id], with_counterparty: current_user)
    end

    def create
      opts = params["contract_cmd_publish"]
      @contract = ContractCmd::Publish.new(valid_params(opts))
      if @contract.project
        redirect_to("/rewards/#{@contract.id}")
      else
        render 'contracts/new'
      end
    end

    def update
      opts = params["contract_cmd_take"]
      @contract = ContractCmd::Take.find(opts["id"], with_counterparty: current_user)
      if @contract.project
        redirect_to("/rewards/#{@contract.id}")
      else
        render 'contracts/new'
      end
    end

    def resolve
      contract_id = params["id"]
      result = ContractCmd::Resolve.new(contract_id)
      result.project
      redirect_to "/core/contracts"
    end

    def graph
      @contract_id = params["id"]
      respond_to do |format|
        format.html
        format.png do
          require 'graphviz'
          @contract_id = params["id"]
          @contract    = Contract.find(params["id"])
          g = GraphViz.new( :G, :type => :digraph )
          contr   = g.add_nodes("CONTRACT #{@contract_id}")
          escrows = @contract.escrows.map do |esc|
            enode = g.add_nodes("ESCROW #{esc.id}", color: "blue", shape: "box")
            esc.fixed_positions.each do |pos|
              pn = g.add_nodes("FP #{pos.id}", color: "red")
              g.add_edges(enode, pn)
              oo = g.add_nodes("O #{pos.offer.id}")
              g.add_edges(pn, oo)
              uu = g.add_nodes("U #{pos.offer.id}/#{pos.offer.user.id}")
              g.add_edges(oo, uu)
            end
            esc.unfixed_positions.each do |pos|
              pn = g.add_nodes("UP #{pos.id}", color: "green")
              g.add_edges(enode, pn)
              oo = g.add_nodes("O #{pos.offer.id}")
              g.add_edges(pn, oo)
              uu = g.add_nodes("U #{pos.offer.id}/#{pos.offer.user.id}")
              g.add_edges(oo, uu)
            end
            enode
          end
          g.add_edges(contr, escrows.first)
          tgt = escrows.first
          escrows[1..-1].each do |esc|
            g.add_edges(tgt, esc)
            tgt = esc
          end
          g.output(png: "/tmp/contract#{@contract_id}.png")
          send_data(File.read("/tmp/contract#{@contract_id}.png"), disposition: 'inline', type: 'image/png', filename: 'img.png')
        end
      end
    end

    def chart
      @contract_id = params["id"]
      @contract = Contract.find @contract_id
      time = BugmTime.now
      list = ["Date,Open,High,Low,Close,Volume"] + @contract.escrows.map do |escrow|
        time = time + 10.minutes
        [ time.strftime("%Y-%m-%dT%H:%M"),
          0,
          1,
          0,
          escrow.ask_positions.first.price,
          0
        ].join(",")
      end
      render plain: list.join("\n")
    end

    private

    def valid_params(params)
      fields = Contract.attribute_names.map(&:to_sym)
      params.permit(fields)
    end

    def new_opts(params)
      opts = {
        type: "Contract::#{params["type"]&.capitalize}",
        price: 0.10,
        maturation: BugmTime.now + 3.minutes,
        user_uuid: current_user.uuid
      }
      key = "stm_issue_uuid" if params["stm_issue_uuid"]
      key = "stm_tracker_uuid" if params["stm_tracker_uuid"]
      id = params["stm_issue_uuid"] || params["stm_tracker_uuid"]
      opts.merge({key => id})
    end
  end
end
