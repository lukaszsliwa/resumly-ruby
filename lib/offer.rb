module Resumly
  class Offer
    include Base

    attr_accessor :_id, :title, :description, :slug, :location, :visible, :locale, :department,
                  :url, :created_at, :updated_at, :requirements, :responsibilities, :company_offers,
                  :bonus_points, :additional_information, :profile_id

    def initialize(options = {})
      options.each do |attr, val|
        method("#{attr}=").call(val)
      end
    end

    class << self
      def find(profile, id)
        attrs = get("/profiles/#{profile}/offers/#{id}")
        Offer.new(attrs.merge(:profile_id => profile))
      end

      def all(profile, params = {})
        offers = get("/profiles/#{profile}/offers", params)
        offers.map do |attrs|
          Offer.new(attrs.merge(:profile_id => profile))
        end
      end
    end

  end
end