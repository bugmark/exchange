module Queries
  Host = GraphQL::ObjectType.define do

    field :host, Types::Exc::HostType do
      description 'Host Query'
      resolve ->(_obj, _args, _ctx) do
        Types::Exc::HostKlas.new
      end
    end

  end
end
