module Queries
  Tracker = GraphQL::ObjectType.define do

    field :tracker, Types::Exchange::TrackerType do
      description 'Tracker info'
      argument :id, !types.Int, "Tracker ID"
      resolve ->(_obj, args, _ctx) do
        ::Tracker.find(args[:id])
      end
    end

    field :trackers, types[Types::Exchange::TrackerType] do
      description 'Tracker list'
      argument :limit, types.Int, "Max number of records to return"
      resolve ->(_obj, args, _ctx) do
        limit = args[:limit] || 10
        ::Tracker.all.order(:id => :desc).limit(limit)
      end
    end

  end
end