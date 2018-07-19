class Types::Exchange::Host::InfoKlas
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

