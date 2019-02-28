# Position type
class Types::Exc::PositionType < Types::Base::Object
  field :id,         Int,                   null: false
  field :uuid,       String,                null: false
  field :volume,     Int,                   null: false
  field :price,      Float,                 null: false
  field :value,      Float,                 null: false
  field :side,       String,                null: false
  field :offer_uuid, String,                null: false
  field :user_uuid,  String,                null: false
  field :user,       Types::Exc::UserType,  null: false
  field :offer,      Types::Exc::OfferType, null: false
end
