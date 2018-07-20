class Types::MutationType < Types::BaseObject

  field :test_field, String, null: false do
    description "an example field added by the generator"
  end

  def test_field
    "hello world"
  end

  field :update_user_name, String, null: false do
    description "an example field added by the generator"
    argument :id, Int, required: true
    argument :name, String, required: true
  end

  def update_user_name(id:, name:)
    user = User.find(id)
    user.name = name
    user.save
    "OK"
  end
end
