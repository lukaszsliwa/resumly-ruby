module Resumly
  class << self
    attr_accessor :token, :version, :host

    def version
      @version ||= 'v1'
    end

    def host
      @host ||= 'api.resumly.com'
    end

    def configure
      yield self
    end
  end

  autoload :Base, 'base'
  autoload :Profile, 'profile'
  autoload :Candidate, 'candidate'
  autoload :Offer, 'offer'

  autoload :ProfileCandidates, 'profile_candidates'
  autoload :ProfileOffers, 'profile_offers'
  autoload :OfferCandidates, 'offer_candidates'
end