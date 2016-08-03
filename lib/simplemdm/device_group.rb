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

    def add_device(device)
      raise "The object you provided is not a device" unless app.kind_of?(SimpleMDM::Device)

      hash, code = fetch("device_groups/#{self.id}/devices/#{device.id}", :post)

      if code == 204
        self['device_ids'] = self['device_ids'] | [device.id]
        true
      else
        false
      end
    end

  end
end
