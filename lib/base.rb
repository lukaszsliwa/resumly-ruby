require 'httparty'
require 'crack'

module Resumly
  module Base
    include ::HTTParty

    base_uri Resumly.host
    format :json

    def self.headers
      accept, token = "application/vnd.resumly-#{Resumly.version}+json", Resumly.token
      { 'Accept' => accept, 'Token' => token }
    end

    def self.get(path, params = {})
      options = { :query => params, :headers => headers }
      result = self.class.get(path, options)
      Crack::JSON.parse(result)
    end
  end
end