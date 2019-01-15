module Mutations
  UsrDep = GraphQL::ObjectType.define do

    field :usr_dep, GraphQL::STRING_TYPE do
      description "Increase User Balance!"
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
