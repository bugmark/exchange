# type for user auth
class Types::Exchange::UserAuthType < Types::Base::Object
  field :id,          Int,    null: true
  field :uuid,        String, null: true
  field :name,        String, null: true
  field :email,       String, null: true
  field :mobile,      String, null: true
  field :balance,     Float,  null: true
  field :basic_token, String, null: true
end
