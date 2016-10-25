module SimpleMDM
  class InstalledApp < Base

    def self.find(id)
      hash, code = fetch("installed_apps/#{id}")

      build hash['data']
    end

    def uninstall
      raise "You cannot uninstall an unmanaged app" if !self.managed

      hash, code = fetch("installed_apps/#{id}", :delete)

      code == 202
    end

  end
end
