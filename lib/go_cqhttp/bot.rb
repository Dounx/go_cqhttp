# frozen_string_literal: true

module GoCQHTTP
  # Wrapper for Client
  class Bot
    def initialize(host:, access_token:)
      @client = Client.new(host: host, access_token: access_token)
    end

    private

    def respond_to_missing?(symbol, *args)
      API.existed?(endpoint(symbol))
    end

    def method_missing(symbol, *args)
      raise ArgumentError unless args.size.zero? || args.first.is_a?(Hash)

      endpoint = endpoint(symbol)
      http_method = API.http_method(endpoint)

      super unless http_method

      @client.send(http_method, endpoint, *args)
    end

    # Mapping method to endpoint
    def endpoint(symbol)
      symbol.to_s
        .gsub("admin_", "admin/")
        .gsub("hidden_", ".")
    end
  end
end
