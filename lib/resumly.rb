module Resumly
  class << self
    attr_accessor :token, :version, :host
    def configure
      yield self
    end
  end
end