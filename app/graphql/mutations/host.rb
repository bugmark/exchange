module Mutations
  Host = GraphQL::ObjectType.define do

    field :host_reset, GraphQL::STRING_TYPE do
      description "Reset the host"

      resolve ->(_obj, _args, _ctx) do
        BugmHost.reset
        "OK"
      end
    end

    field :host_seed, GraphQL::STRING_TYPE do
      description "Reset host and generate seed data"
      argument :cycles,     types.Int
      argument :num_users,  types.Int
      argument :num_issues, types.Int

      resolve ->(_obj, args, _ctx) do
        argh = args.to_h
        opts = {
          cycles:     argh.fetch(:cycles    , 20)   ,
          num_users:  argh.fetch(:num_users , 3)    ,
          num_issues: argh.fetch(:num_issues, 4)
        }
        BugmSeed.new(opts).generate
        "OK"
      end
    end
  end
end
