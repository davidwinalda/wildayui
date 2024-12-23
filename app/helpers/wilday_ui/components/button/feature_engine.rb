module WildayUi
  module Components
    module Button
      module FeatureEngine
        include WildayUi::Components::Button::Features::Loading
        include WildayUi::Components::Button::Features::Dropdown
        include WildayUi::Components::Button::Features::CopyToClipboard
        include WildayUi::Components::Button::Features::ConfirmDialog
        include WildayUi::Components::Button::Features::Tooltip

        BUTTON_FEATURES = begin
          {}
          .merge(Features::Loading.feature_config)
          .merge(Features::Tooltip.feature_config)
          .merge(Features::Dropdown.feature_config)
          .merge(Features::CopyToClipboard.feature_config)
          .merge(Features::ConfirmDialog.feature_config)
          .freeze
        end

        def self.button_features
          BUTTON_FEATURES
        end

        def determine_active_features(loading, dropdown, loading_text = nil, copy_to_clipboard = nil, confirm = nil, tooltip = nil, use_default_controller = true)
          features = {}
          features[:loading] = true if (loading || loading_text.present?) && use_default_controller
          features[:dropdown] = true if dropdown && use_default_controller
          features[:copy_to_clipboard] = true if copy_to_clipboard.present? && use_default_controller
          features[:confirm] = true if confirm.present? && use_default_controller
          features[:tooltip] = true if tooltip.present? && use_default_controller
          features
        end

        def setup_features(active_features, options, use_default_controller)
          return unless use_default_controller && active_features.any?

          active_features.each do |feature, _value|
            feature_config = BUTTON_FEATURES[feature]
            next unless feature_config

            # Skip adding controller for dropdown feature since it's handled by wrapper
            if feature_config[:wrapper_required]
              # For dropdown, only set the action, not the controller
              options[:data][:action] = feature_config[:default_stimulus_action]
            else
              setup_feature_controller(options, feature_config)
            end
          end
        end

        def setup_feature_controller(options, feature_config)
          options[:data] ||= {}

          existing_controller = options.dig(:data, :controller)
          existing_action = options.dig(:data, :action)

          options[:data][:controller] = [
            existing_controller,
            feature_config[:stimulus_controller]
          ].compact.join(" ")

          options[:data][:action] = [
            existing_action,
            feature_config[:default_stimulus_action]
          ].compact.join(" ")
        end
      end
    end
  end
end
