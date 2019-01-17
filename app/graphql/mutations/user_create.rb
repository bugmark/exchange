module Mutations
  UserCreate = GraphQL::ObjectType.define do

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

  end
end

