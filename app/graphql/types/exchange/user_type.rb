# Types::Exchange::UserType = GraphQL::ObjectType.define do
#   name "User"
#   description "A user"
#   field :id     , types.Int
#   field :uuid   , types.String
#   field :name   , types.String
#   field :email  , types.String
#   field :mobile , types.String
#   field :balance, types.Float
# end

class Types::Exchange::UserType < GraphQL::Schema::Object
  field :id     , ID    , null: false
  field :uuid   , String, null: false
  field :name   , String
  field :email  , String
  field :mobile , String
  field :balance, Float
end
