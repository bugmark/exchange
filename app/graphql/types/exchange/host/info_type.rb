module Types
  module Exchange
    module Host
      module InfoBase
        def host_name()   `hostname`.chomp     end
        def host_time()   BugmTime.now         end
        def day_offset()  BugmTime.day_offset  end
        def hour_offset() BugmTime.hour_offset end
      end

      class InfoKlas
        include InfoBase
      end

      class InfoType < Types::Base::Object
        include InfoBase
        field :host_name  , String, null: true, description: "Server hostname"
        field :host_time  , String, null: true, description: "Exchange time"
        field :day_offset , String, null: true, description: "Exchange day offset"
        field :hour_offset, String, null: true, description: "Exchange day offset"
      end
    end
  end
end
