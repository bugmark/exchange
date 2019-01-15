class Mutations::UserDep < Mutations::BaseMutation
  null true

  description "Increase a user's balance"

  argument :id, Integer, required: true
  argument :amount, Float, required: true

  def resolve(id:, amount:)
    user = User.find(id)
    UserCmd::Deposit.new({uuid: user.uuid, amount: amount}).project
    "OK"
  end
end
