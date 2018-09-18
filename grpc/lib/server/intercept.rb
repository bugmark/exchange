module Server
  # implements usr/pwd authentication
  class Intercept < GRPC::ServerInterceptor
    def request_response(request:, call:, method:)
      info 'INTERCEPT BIDI STREAMER', request: request, call: call, method: method
      yield
    end

    def client_streamer(call:, method:)
      info 'INTERCEPT BIDI STREAMER', call: call, method: method
      yield
    end

    def server_streamer(request:, call:, method:)
      info 'INTERCEPT BIDI STREAMER', request: request, call: call, method: method
      yield
    end

    def bidi_streamer(request:, call:, method:)
      info 'INTERCEPT BIDI STREAMER', request: request, call: call, method: method
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
end
