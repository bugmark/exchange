require_relative './host/count_type'
require_relative './host/info_type'

module Types
  module Ex
    # base module
    module HostBase
      def info() Types::Ex::Host::InfoKlas end
      def count() Types::Ex::Host::CountKlas end
    end

    # host class
    class HostKlas
      include HostBase
    end

    # host type
    class Types::Ex::HostType < Types::Base::Object
      field :info , Types::Ex::Host::InfoType, null: true do
        description 'Server info'
      end

      field :count , Types::Ex::Host::CountType, null: true do
        description 'Server counts'
      end
    end
  end
end
