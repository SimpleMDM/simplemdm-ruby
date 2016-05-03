module SimpleMDM
  class AppGroup < Base

    def build(hash = nil)
      @dirty = false

      super
    end

    def self.all
      hash, code = fetch("app_groups")

      hash['data'].collect { |d| build d }
    end

    def self.find(id)
      hash, code = fetch("app_groups/#{id}")

      build hash['data']
    end

    def save
      if @dirty || new?
        params = {}
        params[:name]        = self.name unless self.name.nil?
        params[:auto_deploy] = self.auto_deploy unless self.auto_deploy.nil?

        if new?
          hash, code = fetch("app_groups", :post, params)

          self.id = hash['data']['id']
          self.merge!(hash['data']['attributes'])
        else
          fetch("app_groups/#{self.id}", :patch, params)
        end

        @dirty = false
      end

      self
    end

    def name=(val)
      if val != self.name
        @dirty = true
      end

      self['name'] = val
    end

    def auto_deploy=(val)
      if val != self.auto_deploy
        @dirty = true
      end

      self['auto_deploy'] = val
    end

    def destroy
      raise "You cannot delete an app group that hasn't been created yet" if new?

      hash, code = fetch("app_groups/#{self.id}")

      code == 204
    end

    def add_app(app)
      raise "You must save this app group before changing associations" if new?
      raise "The object you provided is not an app" unless app.kind_of?(SimpleMDM::App)
      raise "You must save the app before associating it" if app.id.nil?

      hash, code = fetch("app_groups/#{self.id}/apps/#{app.id}", :post)

      if code == 204
        self['app_ids'] = self['app_ids'] | [app.id]
        true
      else
        false
      end
    end

    def remove_app(app)
      raise "You must save this app group before changing associations." if new?
      raise "The object you provided is not an app" unless app.kind_of?(SimpleMDM::App)
      raise "The app you provided doesn't exist" if app.id.nil?

      hash, code = fetch("app_groups/#{self.id}/apps/#{app.id}", :delete)

      if code == 204
        self['app_ids'].delete(app.id)
        true
      else
        false
      end
    end

    def add_device_group(device_group)
      raise "You must save this app group before changing associations." if new?
      raise "The object you provided is not a device group" unless device_group.kind_of?(SimpleMDM::DeviceGroup)
      raise "You must save the device_group before associating it" if device_group.id.nil?

      hash, code = fetch("app_groups/#{self.id}/device_groups/#{device_group.id}", :post)

      if code == 204
        self['device_group_ids'] = self['device_group_ids'] | [device_group.id]
        true
      else
        false
      end
    end

    def remove_device_group(device_group)
      raise "You must save this app group before changing associations" if new?
      raise "The object you provided is not a device group" unless device_group.kind_of?(SimpleMDM::DeviceGroup)
      raise "The device group you provided doesn't exist" if device_group.id.nil?

      hash, code = fetch("app_groups/#{self.id}/device_groups/#{device_group.id}", :delete)

      if code == 204
        self['device_group_ids'].delete(device_group.id)
        true
      else
        false
      end
    end

    def add_device(device)
      raise "You must save this app group before changing associations." if new?
      raise "The object you provided is not a device" unless device.kind_of?(SimpleMDM::Device)
      raise "You must save the device before associating it" if device.id.nil?

      hash, code = fetch("app_groups/#{self.id}/devices/#{device.id}", :post)

      if code == 204
        self['device_ids'] = self['device_ids'] | [device.id]
        true
      else
        false
      end
    end

    def remove_device(device)
      raise "You must save this app group before changing associations" if new?
      raise "The object you provided is not a device" unless device.kind_of?(SimpleMDM::Device)
      raise "The device you provided doesn't exist" if device.id.nil?

      hash, code = fetch("app_groups/#{self.id}/devices/#{device.id}", :delete)

      if code == 204
        self['device_ids'].delete(device.id)
        true
      else
        false
      end
    end

    def push_apps
      raise "You cannot push apps for an app group that hasn't been created yet" if new?

      hash, code = fetch("app_groups/#{self.id}/push_apps", :post)

      code == 202
    end

  end
end
