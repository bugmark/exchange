module Queries
  Escrow = GraphQL::ObjectType.define do

    field :escrow, Types::Ex::EscrowType do
      description 'Escrow info'
      argument :id, !types.Int, "Escrow ID"
      resolve ->(_obj, args, _ctx) do
        ::Escrow.find(args[:id])
      end
    end

    field :escrows, types[Types::Ex::EscrowType] do
      description 'Escrow list'
      argument :limit, types.Int, "Max number of records to return"
      resolve ->(_obj, args, _ctx) do
        limit = args[:limit] || 10
        ::Escrow.all.order(:id => :desc).limit(limit)
      end
    end

  end
end
