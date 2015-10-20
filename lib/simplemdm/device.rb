module SimpleMDM
  class Device < Base

    def self.all
      hash, code = fetch("devices")

      hash['data'].collect { |d| build d }
    end

    def self.find(id)
      hash, code = fetch("devices/#{id}")

      build hash['data']
    end

    def installed_apps
      raise "You cannot retrieve installed apps for a device that hasn't been created yet." if new?

      hash, code = fetch("devices/#{id}/installed_apps")

      hash['data'].collect { |a| InstalledApp.build a }
    end

    def lock(options = {})
      params = options.delete_if { |k,v| ![:message, :phone_number, :pin].include?(k) }

      hash, code = fetch("devices/#{id}/lock", :post, params)

      code == 202
    end

    def clear_passcode
      hash, code = fetch("devices/#{id}/clear_passcode", :post)

      code == 202
    end

    def wipe
      hash, code = fetch("devices/#{id}/wipe", :post)

      code == 202
    end

    def push_apps
      hash, code = fetch("devices/#{id}/push_apps", :post)

      code == 202
    end


  end
end
