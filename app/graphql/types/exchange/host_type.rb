require_relative "./host/count_type"
require_relative "./host/info_type"

module Types
  module Exchange
    module HostBase
      def info() Types::Exchange::Host::InfoKlas end
      def types() Types::Exchange::Host::CountKlas end
    end

    class HostKlas
      include HostBase
    end

    class Types::Exchange::HostType < Types::Base::Object
      field :info  , Types::Exchange::Host::InfoType, null: true do
        description "Server info"
      end

      field :count , Types::Exchange::Host::CountType, null: true do
        description "Server counts"
      end
    end
  end
end
