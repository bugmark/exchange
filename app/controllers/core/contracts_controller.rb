module Core
  class ContractsController < ApplicationController

  layout 'core'

    before_action :authenticate_user!, :except => [:index, :show, :resolve, :chart]

    # stm_bug_id (optional)
    def index
      @bug = @repo = nil
      base_scope = Contract.all
      case
        when stm_bug_id = params["stm_bug_id"]&.to_i
          @bug = Bug.find(stm_bug_id)
          @contracts = base_scope.where(stm_bug_id: stm_bug_id)
        when stm_repo_id = params["stm_repo_id"]&.to_i
          @repo = Repo.find(stm_repo_id)
          @contracts = base_scope.where(stm_repo_id: stm_repo_id)
        else
          @contracts = base_scope
      end
    end

    def show
      @contract = Contract.find(params["id"])
    end

    # stm_bug_id or stm_repo_id, type(forecast | reward)
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
      ContractCmd::Resolve.new(contract_id).project
      redirect_to "/core/contracts"
    end

    def graph
      @contract_id = params["id"]
      respond_to do |format|
        format.html
        format.png do
          require 'graphviz'
          @contract_id = params["id"]
          g = GraphViz.new( :G, :type => :digraph )
          hello = g.add_nodes("HELLO")
          world = g.add_nodes("WORLD")
          contr = g.add_nodes("CONTRACT #{@contract_id}")
          g.add_edges(hello, world)
          g.add_edges(world, contr)
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
        user_id: current_user.id
      }
      key = "stm_bug_id" if params["stm_bug_id"]
      key = "stm_repo_id" if params["stm_repo_id"]
      id = params["stm_bug_id"] || params["stm_repo_id"]
      opts.merge({key => id})
    end
  end
end
