InfluxDB::Rails.configure do |config|
  config.influxdb_database = "bugm_access"
  config.influxdb_username = "admin"
  config.influxdb_password = "admin"
  config.influxdb_hosts    = ["localhost"]
  config.influxdb_port     = 8086

  # config.retry = false
  # config.async = false
  # config.open_timeout = 5
  # config.read_timeout = 30
  # config.max_delay = 300

  config.series_name_for_controller_runtimes = "bugm.controller"
  config.series_name_for_view_runtimes       = "bugm.view"
  config.series_name_for_db_runtimes         = "bugm.db"
end
