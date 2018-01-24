module V1
  class Users < V1::App

    helpers do
      def user_details(user)
        {
          uuid:      user.uuid    ,
          usermail:  user.email   ,
          balance:   user.balance ,
          offers:    user.offers.open.map {|offer| offer.uuid} ,
          positions: user.positions.map   {|position| position.uuid}
        }
      end
    end

    resource :users do
      desc "Create a user",
           http_codes: [
             { code: 200, message: "Outcome", model: Entities::Status}
           ],
           consumes: ['multipart/form-data']
      params do
        requires :usermail , type: String
        requires :password , type: String
      end
      post do
        opts    = { email: params[:usermail], password: params[:password] }
        command = UserCmd::Create.new(opts)
        if command.valid?
          command.project
          {status: "OK"}
        else
          {status: "Error", message: command.errors.messages.to_s}
        end
      end

      desc "List all users",
           is_array: true ,
           http_codes: [
                       { code: 200, message: "User list", model: Entities::UserOverview }
                     ]
      get do
        User.all.map do |user|
          {
            uuid:     user.uuid    ,
            usermail: user.email
          }
        end
      end

      desc "Show user detail",
           http_codes: [
             { code: 200, message: "User detail", model: Entities::UserDetail }
           ]
      get ':usermail', requirements: { usermail: /.*/ } do
        user = User.find_by_email(params[:usermail])
        user ? user_details(user) : error!("Not found", 404)
      end

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
