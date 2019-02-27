module Queries
  Host = GraphQL::ObjectType.define do

    field :host, Types::Ex::HostType do
      description 'Host Query'
      resolve ->(_obj, _args, _ctx) do
        Types::Ex::HostKlas.new
      end
    end

  end
end
