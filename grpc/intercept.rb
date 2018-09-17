class InterceptClient < GRPC::ClientInterceptor
  def request_response(request:, call:, method:, metadata:)
    info "INTERCEPT REQUEST_RESPONSE", request, call, method, metadata
    yield
  end

  def client_streamer(request:, call:, method:, metadata:)
    info "INTERCEPT CLIENT STREAMER", request, call, method, metadata
    yield
  end

  def server_streamer(request:, call:, method:, metadata:)
    info "INTERCEPT SERVER STREAMER", request, call, method, metadata
    yield
  end

  def bidi_streamer(request:, call:, method:, metadata:)
    info "INTERCEPT BIDI STREAMER", request, call, method, metadata
    yield
  end

  private

  def info(msg, request = nil, call = nil, method = nil, metadata = nil)
    puts msg
    puts request.inspect
    puts call.inspect
    puts method.inspect
    puts metadata.inspect
  end
end

class InterceptServer < GRPC::ServerInterceptor
  def request_response(request:, call:, method:)
    info "INTERCEPT BIDI STREAMER", request: request, call: call, method: method
    yield
  end

  def client_streamer(call:, method:)
    info "INTERCEPT BIDI STREAMER", call: call, method: method
    yield
  end

  def server_streamer(request:, call:, method:)
    info "INTERCEPT BIDI STREAMER", request: request, call: call, method: method
    yield
  end

  def bidi_streamer(request:, call:, method:)
    info "INTERCEPT BIDI STREAMER", request: request, call: call, method: method
    yield
  end

  private

  def info(msg, request:, call:, method:)
    puts msg
    puts request.inspect
    puts call.inspect
    puts method.inspect
  end
end
