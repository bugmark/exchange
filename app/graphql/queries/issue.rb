module Queries
  Issue = GraphQL::ObjectType.define do

    field :issue, Types::Exchange::IssueType do
      description 'Issue info'
      argument :id, !types.Int, "Issue ID"
      resolve ->(_obj, args, _ctx) do
        ::Issue.find(args[:id])
      end
    end

    field :issues, types[Types::Exchange::IssueType] do
      description 'Issue list'
      argument :limit, types.Int, "Max number of records to return"
      resolve ->(_obj, args, _ctx) do
        limit = args[:limit] || 10
        ::Issue.all.order(:id => :desc).limit(limit)
      end
    end

  end
end