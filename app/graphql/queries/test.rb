module Queries
  Test = GraphQL::ObjectType.define do

    field :test_greeting, GraphQL::STRING_TYPE do
      description 'TEST GREETING'
      resolve ->(_obj, _args, _ctx) { "HELLO at #{Time.now}" }
    end

  end
end
