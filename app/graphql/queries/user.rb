module Queries
  User = GraphQL::ObjectType.define do

    field :user, Types::Exchange::UserType do
      description 'User info'
      argument :id    , types.Int    , 'User ID'
      argument :email , types.String , 'User Email'
      resolve ->(_obj, args, _ctx) do
        case
        when args[:id]    then ::User.find(args[:id])
        when args[:email] then ::User.find_by_email(args[:email]&.strip&.chomp)
        end
      end
    end

    field :basic_token, types.String do
      description 'Basic auth token'
      argument :email   , !types.String, 'Email address'
      argument :password, !types.String, 'Password'
      resolve ->(_obj, args, _ctx) do
        mail = args[:email]
        pass = args[:password]
        user = ::User.find_by_email(mail)
        auth = user&.valid_password?(pass)
        base = ActionController::HttpAuthentication::Basic
        cred = base.encode_credentials(mail, pass)
        auth ? cred : ''
      end
    end

    field :users, types[Types::Exchange::UserType] do
      description 'User list'
      argument :limit, types.Int, 'Max number of records to return'
      resolve ->(_obj, args, _ctx) do
        limit = args[:limit] || 10
        ::User.all.order(:id => :desc).limit(limit)
      end
    end

  end
end
