module Resumly
  class Candidate
    include Base

    attr_accessor :_id, :email, :screen_name, :position,
                  :comments, :tags, :created_at, :updated_at, :profile_id

    def initialize(options = {})
      options.each do |attr, val|
        method("#{attr}=").call(val)
      end
    end

    class << self
      def find(profile, id)
        attrs = get("/profiles/#{profile}/candidates/#{id}")
        Candidate.new(attrs.merge(:profile_id => profile))
      end

      def all(profile, params = {})
        candidates = get("/profiles/#{profile}/candidates", params)
        candidates.map do |attrs|
          Candidate.new(attrs.merge(:profile_id => profile))
        end
      end
    end

  end
end