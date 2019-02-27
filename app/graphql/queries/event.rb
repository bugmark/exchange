module Queries
  Event = GraphQL::ObjectType.define do

    field :event, Types::Ex::EventType do
      description 'Event Info'
      argument :id, !types.Int
      resolve ->(_obj, args, _ctx) do
        ::Event.find(args[:id])
      end
    end

    field :events, types[Types::Ex::EventType] do
      description 'Event list'
      argument :limit, types.Int, "Max number of records to return"
      resolve ->(_obj, args, _ctx) do
        limit = args[:limit] || 10
        ::Event.all.order(:id => :desc).limit(limit)
      end
    end

  end
end
