require "wilday_ui/version_check"
require "wilday_ui/config/theme"

module WildayUi
  class Engine < ::Rails::Engine
    isolate_namespace WildayUi

    # Add lib to autoload paths
    config.autoload_paths << root.join("lib")
    config.eager_load_paths << root.join("lib")

    # Initialize theme configuration
    initializer "wilday_ui.configuration", before: :load_config_initializers do
      Rails.application.reloader.to_prepare do
        Rails.logger.info "[Wilday UI] Theme configuration initialized."
        WildayUi::Config::Theme.configuration ||= WildayUi::Config::Theme::Configuration.new
      end
    end

    # Automatically check for updates
    initializer "wilday_ui.version_check", after: :load_config_initializers do
      Rails.application.reloader.to_prepare do
        Rails.logger.info "[Wilday UI] Version check initialized."
        WildayUi::VersionCheck.check_for_update
      end
    end

    # Automatically include helpers in views
    initializer "wilday_ui.helpers" do
      ActiveSupport.on_load(:action_view) do
        include WildayUi::ApplicationHelper
      end
    end

    # Configure asset paths and automatic precompilation
    initializer "wilday_ui.assets" do |app|
      # Add engine asset paths
      engine_asset_paths = [
        root.join("app/assets/stylesheets"),
        root.join("app/javascript"),
        root.join("app/assets/builds")
      ]

      # Add dummy app assets path in development
      if Rails.env.development?
        engine_asset_paths << root.join("test/dummy/app/assets/builds")

        # Create symlink for dummy app assets if it doesn't exist
        dummy_builds_path = root.join("test/dummy/app/assets/builds/wilday_ui")
        engine_builds_path = root.join("app/assets/builds/wilday_ui")

        unless File.exist?(dummy_builds_path)
          FileUtils.mkdir_p(dummy_builds_path.parent)
          FileUtils.ln_sf(engine_builds_path, dummy_builds_path)
          Rails.logger.info "[Wilday UI] Created symlink for dummy app assets"
        end
      end

      # Add all asset paths to Rails
      engine_asset_paths.each { |path| app.config.assets.paths << path }
      Rails.logger.info "[Wilday UI] Asset paths added: #{app.config.assets.paths}"

      # Automatically precompile all CSS files in wilday_ui directory
      css_files = Dir[root.join("app/assets/stylesheets/wilday_ui/**/*.css")].map do |file|
        file.split("app/assets/stylesheets/").last
      end

      # Precompile only the bundled JavaScript file
      app.config.assets.precompile += css_files
      app.config.assets.precompile += %w[wilday_ui/index.js]

      Rails.logger.info "[Wilday UI] CSS files precompiled: #{css_files}"
      Rails.logger.info "[Wilday UI] JS files precompiled: wilday_ui/index.js"
    end
  end
end
