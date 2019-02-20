# user type
class Types::Exchange::UserType < Types::Base::Object
  field :id,      Int,    null: false
  field :uuid,    String, null: false
  field :name,    String, null: false
  field :email,   String, null: false
  field :mobile,  String, null: true
  field :balance, Float,  null: false
end
