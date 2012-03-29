module Resumly
  class ProfileCandidates < Candidate
    def initialize(profile)
      @profile = profile
    end

    def find(id)
      self.class.find(@profile.subdomain, id)
    end

    def all(params = {})
      self.class.all(@profile.subdomain, params)
    end
  end
end