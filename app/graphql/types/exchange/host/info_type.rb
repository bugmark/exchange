class InfoKlas
  def host_name
    `hostname`.chomp
  end

  def host_time
    BugmTime.now
  end

  def day_offset
    BugmTime.day_offset
  end

  def hour_offset
    BugmTime.hour_offset
  end
end

class Types::Exchange::Host::InfoType < Types::Base::Object

  field :host_name  , String, null: true, description: "Server hostname"
  def host_name
    `hostname`.chomp
  end

  field :host_time  , String, null: true, description: "Exchange time"
  def host_time
    BugmTime.now
  end

  field :day_offset , String, null: true, description: "Exchange day offset"
  def day_offset
    BugmTime.day_offset
  end

  field :hour_offset, String, null: true, description: "Exchange day offset"
  def hour_offset
    BugmTime.hour_offset
  end

end

