require 'rest-client'
require 'json'
require 'hashie'

module SimpleMDM
  class Base < Hashie::Mash

    def self.build(hash = nil)
      if hash
        attrs = {}

        if hash['id']
          attrs[:id] = hash['id']
        end

        if hash['attributes']
          attrs.merge!(hash['attributes'])
        end

        if hash['relationships']
          if hash['relationships']['device_group']
            attrs['device_group_id'] = hash['relationships']['device_group']['data']['id']
          end

          if hash['relationships']['device_groups']
            attrs['device_group_ids'] = hash['relationships']['device_groups']['data'].collect { |o| o['id'] }
          end

          if hash['relationships']['apps']
            attrs['app_ids'] = hash['relationships']['apps']['data'].collect { |o| o['id'] }
          end
        end

        new attrs
      end
    end

    private

    def new?
      self.id.nil?
    end

    def self.fetch(method, verb = :get, params = {})
      headers = { 'SIMPLEMDM-CLIENT-VERSION' => SimpleMDM::VERSION }
      url  = SimpleMDM.api_url + method
      if [:get, :delete].include? verb
        resp = RestClient.send(verb, url, headers)
      else
        resp = RestClient.send(verb, url, params, headers)
      end

      begin
        hash = JSON.parse(resp)
      rescue JSON::ParserError
        hash = nil
      end

      code = resp.code

      return hash, code
    end

    def fetch(method, verb = :get, params = {})
      self.class.fetch(method, verb, params)
    end

  end
end
