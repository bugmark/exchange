module Queries
  User = GraphQL::ObjectType.define do

    field :user, Types::Exchange::UserType do
      description 'User info'
      argument :id, !types.Int, "User ID"
      resolve ->(_obj, args, _ctx) do
        ::User.find(args[:id])
      end
    end

    field :users, types[Types::Exchange::UserType] do
      description 'User list'
      argument :limit, types.Int, "Max number of records to return"
      resolve ->(_obj, args, _ctx) do
        limit = args[:limit] || 10
        ::User.all.order(:id => :desc).limit(limit)
      end
    end

  end
end
