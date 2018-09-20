require_relative "./host/info_type"
# require_relative "./host/count_type"

class HostKlas
  def info
    InfoKlas.new
  end
end

class Types::Exchange::HostType < Types::Base::Object
  # --------------------------------------------------------------
  field :info  , Types::Exchange::Host::InfoType, null: true do
    description "Server info"
  end

  # def info
  #   InfoKlas.new
  # end

  # --------------------------------------------------------------
  # field :count , Types::Exchange::Host::CountType, null: true do
  #   description "Server counts"
  # end

  # def count
  #   Types::Exchange::Host::CountType.new
  # end
end
