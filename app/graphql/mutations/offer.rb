# - [ ] GraphQL Command: offerCreateBuy
# - [ ] GraphQL Command: offerCancel
# - [ ] GraphQL Command: offerCreateClone
# - [ ] GraphQL Command: offerCreateCounter
# - [ ] GraphQL Command: offerCreateSell
# - [ ] GraphQL Command: offerExpire
# - [ ] GraphQL Command: offerSuspend

module Mutations
  Offer = GraphQL::ObjectType.define do

    field :user_create, GraphQL::STRING_TYPE do
      description "Create a User"
      argument :id,       GraphQL::STRING_TYPE
      argument :password, GraphQL::STRING_TYPE
      argument :name,     GraphQL::STRING_TYPE
      argument :amount,   GraphQL::FLOAT_TYPE

      resolve ->(_obj, args, _ctx) do
        opts = {
          email:    args[:email]   ,
          password: args[:password],
          name:     args[:name]    ,
          amount:   args[:amount]
        }
        UserCmd::Create.new(opts).project
        "OK"
      end
    end

    field :user_withdraw, GraphQL::STRING_TYPE do
      description "Decrease User Balance"
      argument :id,     GraphQL::INT_TYPE
      argument :amount, GraphQL::FLOAT_TYPE

      resolve ->(_obj, args, _ctx) do
        user = User.find(args[:id])
        opts = {uuid: user.uuid, amount: args[:amount]}
        UserCmd::Withdraw.new(opts).project
        "OK"
      end
    end

    field :user_deposit, GraphQL::STRING_TYPE do
      description "Increase User Balance"
      argument :id,     GraphQL::INT_TYPE
      argument :amount, GraphQL::FLOAT_TYPE

      resolve ->(_obj, args, _ctx) do
        user = User.find(args[:id])
        opts = {uuid: user.uuid, amount: args[:amount]}
        UserCmd::Deposit.new(opts).project
        "OK"
      end
    end

  end
end
