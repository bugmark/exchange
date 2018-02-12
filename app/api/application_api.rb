class InfluxLogger < Grape::Middleware::Base

  def before
    @time = Time.now
  end

  def after
    return nil if Rails.env.test?
    @time   = Time.now - @time
    @status = lcl_response&.status
    @size   = lcl_response&.body&.join&.size
    InfluxDB::Rails.client.write_point "bmx.api", {tags: tags, values: fields}
    nil
  end

  private

  def lcl_response
    return @app_response if @app_response.is_a?(Rack::Response)
    @lcl_response ||= Rack::Response.new(@app_response[2], @app_response[0], @app_response[1])
  end

  def tags
    {
      method: env['REQUEST_METHOD'] ,
      path:   env['PATH_INFO']      ,
      query:  env['QUERY_STRING']   ,
      status: @status || "NA"
    }.delete_if {|_k, v| v.nil?}
  end

  def fields
    {
      time: @time   ,
      size: @size || 0
    }.delete_if {|_k, v| v.nil?}
  end
end

class ApplicationApi < Grape::API

  use InfluxLogger

  mount V1::Base    => "/v1"
  mount Vtest::Base => "/vtest"
end

