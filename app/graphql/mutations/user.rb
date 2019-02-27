module Mutations
  User = GraphQL::ObjectType.define do

    field :user_create, Types::Ex::UserType do
      description "Create a User"
      argument :email    , GraphQL::STRING_TYPE
      argument :password , GraphQL::STRING_TYPE
      argument :name     , GraphQL::STRING_TYPE
      argument :amount   , GraphQL::FLOAT_TYPE

      resolve ->(_obj, args, _ctx) do
        opts = {
          email:    args[:email]                                    ,
          password: args[:password] || 'bugmark'                    ,
          name:     args[:name]     || args[:email].split('@').first ,
          amount:   args[:amount]   || 1000.00
        }
        result = UserCmd::Create.new(opts).project
        result.user
      end
    end

    field :user_deposit, GraphQL::STRING_TYPE do
      description "Increase User Balance"
      argument :id,     GraphQL::INT_TYPE
      argument :amount, GraphQL::FLOAT_TYPE

      resolve ->(_obj, args, _ctx) do
        user = ::User.find(args[:id])
        opts = {uuid: user.uuid, amount: args[:amount]}
        UserCmd::Deposit.new(opts).project
        "OK"
      end
    end

    field :user_withdraw, GraphQL::STRING_TYPE do
      description "Decrease User Balance"
      argument :id,     GraphQL::INT_TYPE
      argument :amount, GraphQL::FLOAT_TYPE

      resolve ->(_obj, args, _ctx) do
        user = ::User.find(args[:id])
        opts = {uuid: user.uuid, amount: args[:amount]}
        UserCmd::Withdraw.new(opts).project
        "OK"
      end
    end
  end
end
