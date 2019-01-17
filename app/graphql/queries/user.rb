module Queries
  User = GraphQL::ObjectType.define do

    field :user_greeting, GraphQL::STRING_TYPE do
      description 'User User'
      resolve ->(_obj, _args, _ctx) { "HELLO at #{Time.now}" }
    end

  end
end
