require_relative "./info_klas"

class Types::Exchange::Host::InfoType < Types::BaseObject
  field :host_name  , String, null: true, description: "Server hostname"
  field :host_time  , String, null: true, description: "Exchange time"
  field :day_offset , String, null: true, description: "Exchange day offset"
  field :hour_offset, String, null: true, description: "Exchange day offset"
end

