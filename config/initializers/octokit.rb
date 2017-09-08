Octokit.configure do |c|
  c.login    = 'andyl'
  c.password = '03d5a8f96096366' + 'ab4ad80b6e823c3d49b82fee2' # TODO: extract to .env
end

stack = Faraday::RackBuilder.new do |builder|
  builder.use Faraday::HttpCache, serializer: Marshal, shared_cache: false
  builder.use Octokit::Response::RaiseError
  builder.adapter Faraday.default_adapter
end
Octokit.middleware = stack
