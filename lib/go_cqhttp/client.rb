# frozen_string_literal: true

require "json"
require "net/http"

module GoCQHTTP
  # Client for HTTP request
  class Client
    attr_accessor :host, :access_token

    def initialize(host:, access_token:)
      @host = host
      @access_token = access_token
    end

    def post(endpoint, params = {})
      uri = URI.parse(url(endpoint))
      uri.query = URI.encode_www_form(access_token: access_token)
      JSON.parse(Net::HTTP.post_form(uri, params).body)
    end

    def get(endpoint, params = {})
      uri = URI.parse(url(endpoint))
      uri.query = URI.encode_www_form(params.merge(access_token: access_token))
      JSON.parse(Net::HTTP.get(uri))
    end

    private

    def url(endpoint)
      "#{host}/#{endpoint}"
    end
  end
end
