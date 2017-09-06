Octokit.configure do |c|
  c.login    = 'andyl'
  c.password = 'b0dd9095b49f07a2897b1aa2e010478800d68eb6'
end

stack = Faraday::RackBuilder.new do |builder|
  builder.use Faraday::HttpCache, serializer: Marshal, shared_cache: false
  builder.use Octokit::Response::RaiseError
  builder.adapter Faraday.default_adapter
end
Octokit.middleware = stack
