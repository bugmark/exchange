module Mutations
  UserWithdraw = GraphQL::ObjectType.define do

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

  end
end
