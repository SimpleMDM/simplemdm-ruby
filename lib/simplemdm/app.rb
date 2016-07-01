module SimpleMDM
  class App < Base

    def build(hash = nil)
      @dirty = false
      @binary_data = nil

      super
    end

    def self.all
      hash, code = fetch("apps")

      hash['data'].collect { |d| build d }
    end

    def self.find(id)
      hash, code = fetch("apps/#{id}")

      build hash['data']
    end

    def binary=(val)
      raise "binary must be a File object" unless val.kind_of? File

      @dirty = true
      @binary_file = val
    end

    def save
      if (@dirty || new?) && @binary_file
        params = { binary: @binary_file }

        if new?
          hash, code = fetch("apps", :post, params)

          self.id = hash['data']['id']
          self.merge!(hash['data']['attributes'])
        else
          hash, code = fetch("apps/#{self.id}", :patch, params)
          self.merge!(hash['data']['attributes'])
        end

        @dirty       = false
        @binary_file = nil
      end

      self
    end

    def destroy
      raise "You cannot delete an app that hasn't been created yet." if new?

      hash, code = fetch("apps/#{self.id}", :delete)

      code == 204
    end

  end
end
