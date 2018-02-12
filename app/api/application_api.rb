class InfluxLogger < Grape::Middleware::Base

  def before
    @time = Time.now
  end

  def after
    return nil if Rails.env.test?
    @time   = Time.now - @time
    @status = @app_response&.status
    @size   = @app_response&.body&.join&.size
    InfluxDB::Rails.client.write_point "bmx.api", {tags: tags, values: fields}
    nil
  end

  private

  def tags
    {
      method: env['REQUEST_METHOD'] ,
      path:   env['PATH_INFO']      ,
      query:  env['QUERY_STRING']   ,
      status: @status || "NA"
    }
  end

  def fields
    {
      time: @time   ,
      size: @size || 0
    }
  end
end

class ApplicationApi < Grape::API

  use InfluxLogger

  mount V1::Base    => "/v1"
  mount Vtest::Base => "/vtest"
end

