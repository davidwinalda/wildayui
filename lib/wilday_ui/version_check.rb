require "net/http"
require "json"

module WildayUi
  class VersionCheck
    def self.check_for_update
      return unless Rails.env.development?

      current_version = Gem.loaded_specs["wilday_ui"]&.version&.to_s || WildayUi::VERSION
      latest_version = fetch_latest_version

      if latest_version && Gem::Version.new(latest_version) > Gem::Version.new(current_version)
        puts "\n\e[33m[Wilday UI] Update available!"
        puts "You are using version #{current_version}, but the latest version is #{latest_version}."
        puts "To update, run: `bundle update wilday_ui` or update your Gemfile to the latest version\e[0m\n"
        Rails.logger.warn <<~WARNING
          [Wilday UI] You are using version #{current_version}, but the latest version is #{latest_version}.
          To update, run `bundle update wilday_ui` or update your Gemfile to the latest version.
        WARNING
      end
    end

    private

    def self.fetch_latest_version
      url = URI("https://rubygems.org/api/v1/gems/wilday_ui.json")
      response = Net::HTTP.get(url)
      data = JSON.parse(response)
      data["version"]
    rescue StandardError => e
      Rails.logger.info "[Wilday UI] Could not check for updates: #{e.message}"
      nil
    end
  end
end
