module Utils
  module UrlSafeTokenGenerator
    def self.call
      SecureRandom.uuid
    end
  end
end
