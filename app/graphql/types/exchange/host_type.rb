require_relative "./host_klas"
require_relative "./host/info_klas"
require_relative "./host/count_klas"

class Types::Exchange::HostType < Types::Base::Object
  field :info  , Types::Exchange::Host::InfoType , null: true, description: "Server info"
  def info
    Types::Exchange::Host::InfoKlas.new
  end

  field :count , Types::Exchange::Host::CountType, null: true, description: "Server counts"
  def count
    Types::Exchange::Host::CountKlas.new
  end
end
