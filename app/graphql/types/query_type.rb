class Types::QueryType < Types::BaseObject
  field :test_field, String, null: false do
    description "An example field added by the generator"
  end

  def test_field
    "Hello World!"
  end

  field :users, [Types::Exchange::UserType], null: true do
    description "This and that and this"
  end

  def users
    User.all
  end

  field :user, Types::Exchange::UserType, null: true do
    description "This and that and this"
    argument :id, Int, required: true
  end

  def user(id:)
    User.find(id)
  end

  field :bugm_time, String, null: true do
    description "Current Exchange Time"
  end

  def bugm_time
    BugmTime.now.to_s
  end
end
