module V1
  class Users < V1::App

    helpers do
      def user_details(user)
        opts = {
          uuid:     user.uuid    ,
          usermail: user.email   ,
          balance:  user.balance
        }
        opts[:offers]    = user.offers.open.map {|offer| offer.uuid}       if params[:offers]
        opts[:positions] = user.positions.map   {|position| position.uuid} if params[:positions]
        opts
      end
    end

    resource :users do

      # ---------- create a user ----------
      # TODO: return error code for duplicate user
      desc "Create a user", {
        success:  Entities::Status         ,
        consumes: ['multipart/form-data']  ,
        detail: <<-EOF.strip_heredoc
          Create a user.  Supply an optional opening balance.  (Default 0.0)
        EOF
      }
      params do
        requires :usermail , type: String , desc: "user email"
        requires :password , type: String , desc: "user password"
        optional :balance  , type: Float  , desc: "opening balance"
      end
      post do
        opts = { email: params[:usermail], password: params[:password] }
        opts[:balance] = params[:balance] if params[:balance]
        command = UserCmd::Create.new(opts)
        if command.valid?
          command.project
          {status: "OK"}
        else
          {status: "error", message: command.errors.messages.to_s}
        end
      end

      # ---------- list user ----------
      desc "List all users", {
        is_array: true ,
        success:  Entities::UserOverview
      }
      get do
        present(User.all, with: Entities::UserOverview)
      end

      # ---------- show user detail ----------
      desc "Show user detail",
           http_codes: [
             { code: 200, message: "User detail", model: Entities::UserDetail }
           ]
      params do
        requires :usermail , type: String , desc: "user email address"
        optional :offers   , type: Boolean, desc: "include open offers"
        optional :positions, type: Boolean, desc: "include open positions"
      end
      get ':usermail', requirements: { usermail: /.*/ } do
        user = User.find_by_email(params[:usermail])
        user ? user_details(user) : error!("Not found", 404)
      end

      # ---------- create a user ----------
      desc "Deposit funds",
           http_codes: [
             { code: 200, message: "Deposit funds", model: Entities::Status }
           ],
           consumes: ['multipart/form-data']
      params do
        requires :amount , type: Float
      end
      put ':uuid/deposit' do
        user = User.find_by_uuid(params[:uuid])
        args = {uuid: params[:uuid], amount: params[:amount] }
        cmd  = UserCmd::Deposit.new(args)
        if user && cmd.valid?
          cmd.project
          {status: "OK"}
        else
          {status: "Error"}
        end
      end

      # ---------- create a user ----------
      desc "Withdraw funds",
           http_codes: [
             { code: 200, message: "Withdraw funds" }
           ],
           consumes: ['multipart/form-data']
      params do
        requires :amount , type: Float
      end
      put ':uuid/withdraw' do
        user = User.find_by_uuid(params[:uuid])
        args = {uuid: params[:uuid], amount: params[:amount] }
        cmd  = UserCmd::Withdraw.new(args)
        if user && cmd.valid?
          cmd.project
          {status: "OK"}
        else
          {status: "Error"}
        end
      end
    end
  end
end
