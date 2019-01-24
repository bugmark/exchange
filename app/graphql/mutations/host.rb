module Mutations
  Host = GraphQL::ObjectType.define do

    field :host_reset, GraphQL::STRING_TYPE do
      description "Reset the host"

      resolve ->(_obj, _args, _ctx) do
        BugmHost.reset
        "OK"
      end
    end

  end
end
