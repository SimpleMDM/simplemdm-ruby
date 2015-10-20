module SimpleMDM
  class DeviceGroup < Base

    def self.all
      hash, code = fetch("device_groups")

      hash['data'].collect { |d| build d }
    end

    def self.find(id)
      hash, code = fetch("device_groups/#{id}")

      build hash['data']
    end

  end
end
