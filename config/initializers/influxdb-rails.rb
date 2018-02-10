InfluxDB::Rails.configure do |config|
  config.influxdb_database = "bugm_log"
  config.influxdb_username = "admin"
  config.influxdb_password = "admin"
  config.influxdb_hosts    = ["localhost"]
  config.influxdb_port     = 8086

  config.retry = false
  config.async = false
  config.open_timeout = 5
  config.read_timeout = 30
  config.max_delay    = 300

  config.series_name_for_controller_runtimes = "bmx.controller"
  config.series_name_for_view_runtimes       = "bmx.view"
  config.series_name_for_db_runtimes         = "bmx.db"
end

list = InfluxDB::Rails.client.list_databases.map {|el| el["name"]}
%w(bugm_log bugm_stats).each do |db|
  InfluxDB::Rails.client.create_database(db) unless list.include?(db)
end

InfluxStats = InfluxDB::Client.new "bugm_stats", {
  hosts:    %w(localhost)   ,
  username: "admin"         ,
  password: "admin"
}

InfluxAdmin = InfluxDB::Client.new "bugm_log", {
  hosts:    %w(localhost)   ,
  username: "admin"         ,
  password: "admin"
}
