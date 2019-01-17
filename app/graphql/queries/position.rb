module Queries
  Position = GraphQL::ObjectType.define do

    field :position, Types::Exchange::PositionType do
      description 'Position info'
      argument :id, !types.Int, "Position ID"
      resolve ->(_obj, args, _ctx) do
        ::Position.find(args[:id])
      end
    end

    field :positions, types[Types::Exchange::PositionType] do
      description 'Position list'
      argument :limit, types.Int, "Max number of records to return"
      resolve ->(_obj, args, _ctx) do
        limit = args[:limit] || 10
        ::Position.all.order(:id => :desc).limit(limit)
      end
    end

  end
end