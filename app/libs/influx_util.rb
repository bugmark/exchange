class InfluxUtil
  class << self

    def has_influx?
      File.exist?("/etc/influxdb/influxdb.conf")
    end

  end
end