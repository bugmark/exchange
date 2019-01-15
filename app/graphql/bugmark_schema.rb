#HI
class BugmarkSchema < GraphQL::Schema
  mutation(Types::MutationType)
  query(Types::QueryType)
end
