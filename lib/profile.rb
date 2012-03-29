module Resumly
  class Profile
    include Base

    attr_accessor :subdomain, :name, :created_at

    def initialize(options = {})
      options.each do |attr, val|
        method("#{attr}=").call(val)
      end
    end

    class << self
      def find(id)
        attrs = get("/profiles/#{id}")
        Profile.new(attrs)
      end

      def all(params = {})
        profiles = get("/profiles", params)
        profiles.map do |attrs|
          Profile.new(attrs)
        end
      end
    end

    def candidates
      @candidates ||= ProfileCandidates.new(self)
    end

    def offers
      @offers ||= ProfileOffers.new(self)
    end
  end
end