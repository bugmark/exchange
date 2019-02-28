require_relative './host/count_type'
require_relative './host/info_type'

# Host type
class Types::Exc::HostType < Types::Base::Object
  field :info , Types::Exc::Host::InfoType, null: true do
    description 'Server info'
  end

  field :count , Types::Exc::Host::CountType, null: true do
    description 'Server counts'
  end
end

# Host klas
class Types::Exc::HostKlas
  def info() Types::Exc::Host::InfoType end
  def count() Types::Exc::Host::CountType end
end
