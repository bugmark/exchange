module Queries
  Contract = GraphQL::ObjectType.define do

    field :contract, Types::Exc::ContractType do
      description 'Contract info'
      argument :id, !types.Int, 'Contract ID'
      resolve ->(_obj, args, _ctx) do
        ::Contract.find(args[:id])
      end
    end

    field :contracts, types[Types::Exc::ContractType] do
      description 'Contract list'
      argument :limit, types.Int, 'Max number of records to return'
      resolve ->(_obj, args, _ctx) do
        limit = args[:limit] || 10
        ::Contract.all.order(:id => :desc).limit(limit)
      end
    end

  end
end
