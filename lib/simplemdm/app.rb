module SimpleMDM
  class App < Base

    # overwrite base class
    def initialize(source_hash = nil, default = nil, &blk)
      if source_hash && source_hash.kind_of?(Hash) && binary = source_hash[:binary]
        self.binary = binary
        source_hash.delete(:binary)
      end

      super(source_hash, detault, &blk)
    end

    def build(hash = nil)
      @dirty = false
      @binary_file = nil

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

    def name=(val)
      if val != self.name
        @dirty = true
      end

      self['name'] = val
    end

    def save
      raise "binary must be set before saving" if new? && @binary_file.nil?

      if @dirty || new?
        params = {}
        params[:name]   = self.name unless self.name.nil?
        params[:binary] = @binary_file if @binary_file

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
