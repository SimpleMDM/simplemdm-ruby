require 'singleton'

module SimpleMDM
  class Account < Hash
    include Singleton

    def initialize
      hash, code = SimpleMDM::Base.fetch("account")

      self['name'] = hash['data']['attributes']['name']
    end

    def name
      self['name']
    end

  end
end
