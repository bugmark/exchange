class BugmHost

  class << self
    def name
      ENV['SYSNAME']
    end

    def datastore
      return "permanent" if name == "bugmark-net"
      "mutable"
    end

    def reset
      reset_influx
      reset_grafana
      reset_postgres
    end

    private

    def reset_postgres
      tables = %w(Repo User Offer Escrow Position Amendment Contract Event)
      tables.each {|el| Object.const_get(el).destroy_all}
      BugmTime.clear_offset
      UserCmd::Create.new({email: 'admin@bugmark.net', password: 'bugmark'}).project
    end

    def reset_grafana

    end

    def reset_influx
      return
      return unless InfluxUtil.has_influx?
      InfluxStats.delete_database("bugm_stats")
      InfluxStats.create_database("bugm_stats")
    end
  end
end