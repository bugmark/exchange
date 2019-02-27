require_relative '../ext/user_auth'

module Queries
  User = GraphQL::ObjectType.define do

    field :user, Types::Ex::UserType do
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

    field :user_auth, Types::Ex::UserAuthType do
      description 'User auth'
      argument :email   , !types.String, 'Email address'
      argument :password, !types.String, 'Password'
      resolve ->(_obj, args, _ctx) do
        ::UserAuth.new(args[:email], args[:password])
      end
    end

    field :users, types[Types::Ex::UserType] do
      description 'User list'
      argument :limit, types.Int, 'Max number of records to return'
      resolve ->(_obj, args, _ctx) do
        limit = args[:limit] || 10
        ::User.all.order(:id => :desc).limit(limit)
      end
    end

  end
end
