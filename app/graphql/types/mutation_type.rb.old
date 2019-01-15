class Types::MutationType < Types::Base::Object

  field :user_dep, String, mutation: Mutations::UserDep

  # --------------------------------------------------------------------

  field :user_create, String, null: false do
    description "create a user"
    argument :email, String, required: true
    argument :password, String, required: true
    argument :name, String, required: false
    argument :amount, Float, required: false
  end

  def user_create(args)
    UserCmd::Create.new(args).project
    "OK"
  end

  # --------------------------------------------------------------------

  field :user_deposit, String, null: false do
    description "Increase a user balance"
    argument :id, Int, required: true
    argument :amount, Float, required: true
  end

  def user_deposit(id:, amount:)
    user = User.find(id)
    UserCmd::Deposit.new({uuid: user.uuid, amount: amount}).project
    "OK"
  end

  # --------------------------------------------------------------------

  field :user_withdraw, String, null: false do
    description "Decrease a user balance"
    argument :id, Int, required: true
    argument :amount, Float, required: true
  end

  def user_withdraw(id:, amount:)
    user = User.find(id)
    UserCmd::Withdraw.new({uuid: user.uuid, amount: amount}).project
    "OK"
  end

  # --------------------------------------------------------------------

  field :user_update, String, null: false do
    description "Update a user name"
    argument :id, Int, required: true
    argument :name, String, required: true
    argument :email, String, required: true
    argument :mobile, String, required: true
  end

  def user_update(id:, name:, email:, mobile:)
    user = User.find(id)
    user.name = name if name
    user.email = email if email
    user.mobile = mobile if mobile
    user.save
    "OK"
  end
end
