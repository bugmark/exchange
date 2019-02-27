# User type
class Types::Ex::UserType < Types::Base::Object
  field :id,      Int,         null: false
  field :uuid,    String,      null: false
  field :name,    String,      null: true
  field :email,   String,      null: false
  field :mobile,  String,      null: true
  field :balance, Float,       null: false
  field :offers,  [Types::Ex::OfferType], null: true
end

UserType = Types::Ex::UserType
