class Types::QueryType < Types::BaseObject
  # Root-level fields: entry points for queries on the schema.

  field :test_field, String, null: false do
    description "An example field added by the generator"
  end

  def test_field
    "Hello World!"
  end

  field :user, Types::Exchange::UserType do
    description "User"
  end
end
