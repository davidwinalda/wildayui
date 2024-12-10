require "wilday_ui/version_check"

module WildayUi
  class Engine < ::Rails::Engine
    isolate_namespace WildayUi

    # Automatically check for updates
    initializer "wilday_ui.version_check" do
      Rails.application.config.after_initialize do
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
      app.config.assets.paths << root.join("app/assets/stylesheets")

      # Automatically precompile all CSS files in wilday_ui directory
      css_files = Dir[root.join("app/assets/stylesheets/wilday_ui/**/*.css")].map do |file|
        file.split("app/assets/stylesheets/").last
      end

      app.config.assets.precompile += css_files
    end
  end
end
