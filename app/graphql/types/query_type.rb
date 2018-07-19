class Types::QueryType < Types::BaseObject

  # --------------------------------------------------
  field :hello, String, null: false do
    description "GraphQL test - Hello World!"
  end

  def hello
    "Hello World!"
  end

  # --------------------------------------------------
  field :host, Types::Exchange::HostType, null: true do
    description "Host info"
  end

  def host
    Types::Exchange::HostKlas.new
  end

  # --------------------------------------------------
  field :users, [Types::Exchange::UserType], null: true do
    description "This and that and this"
  end

  def users
    User.all
  end

  # --------------------------------------------------
  field :user, Types::Exchange::UserType, null: true do
    description "This and that and this"
    argument :id, Int, required: true
  end

  def user(id:)
    User.find(id)
  end


end
