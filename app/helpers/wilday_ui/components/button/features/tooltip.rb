module WildayUi
  module Components
    module Button
      module Features
        module Tooltip
          FEATURE_CONFIG = {
            wrapper_required: true,
            stimulus_controller: "tooltip",
            default_stimulus_action: {
              hover: "mouseenter->tooltip#show mouseleave->tooltip#hide focusin->tooltip#show focusout->tooltip#hide",
              click: "click->tooltip#toggle"
            }
          }.freeze

          def self.feature_config
            { tooltip: FEATURE_CONFIG }
          end

          def setup_tooltip_options(options, additional_classes, tooltip, wrapper_data)
            tooltip_config = normalize_tooltip_options(tooltip)

            # Check if dropdown is present
            has_dropdown = wrapper_data[:controller]&.include?("dropdown")
            has_clipboard = wrapper_data[:controller]&.include?("clipboard")

            # Get the appropriate action based on trigger type
            # Force hover behavior if dropdown is present
            trigger_type = (has_dropdown || has_clipboard) ? :hover : tooltip_config[:trigger].to_sym
            tooltip_action = FEATURE_CONFIG[:default_stimulus_action][trigger_type]

            # Merge controllers
            existing_controller = wrapper_data[:controller]
            wrapper_data[:controller] = [
              existing_controller,
              FEATURE_CONFIG[:stimulus_controller]
            ].compact.join(" ")

            # Merge actions
            existing_action = wrapper_data[:action]
            if has_dropdown
              # Keep the dropdown toggle action and add tooltip hover actions
              wrapper_data[:action] = [
                "click->dropdown#toggle",  # Ensure dropdown action comes first
                tooltip_action
              ].compact.join(" ")
            elsif has_clipboard
              # Keep the clipboard copy action and add tooltip hover actions
              wrapper_data[:action] = [
                "click->clipboard#copy click->button#toggleLoading",
                tooltip_action
              ].compact.join(" ")
            else
              wrapper_data[:action] = [
                existing_action,
                tooltip_action
              ].compact.join(" ")
            end

            # Handle theme data
            theme = tooltip_config[:theme]
            theme_name = theme.is_a?(Hash) ? theme[:name] : theme

            wrapper_data.merge!(
              tooltip_content_value: tooltip_config[:content],
              tooltip_position_value: tooltip_config[:position],
              tooltip_align_value: tooltip_config[:align],
              tooltip_trigger_value: trigger_type,
              tooltip_show_delay_value: tooltip_config[:delay][:show],
              tooltip_hide_delay_value: tooltip_config[:delay][:hide],
              tooltip_offset_value: tooltip_config[:offset],
              tooltip_theme_value: theme_name,
              tooltip_size_value: tooltip_config[:size],
              tooltip_arrow_value: tooltip_config[:arrow]
            )

            # Add custom theme styles if present
            if theme.is_a?(Hash) && theme[:custom]
              custom_styles = []
              custom_styles << "--tooltip-text-color: #{theme[:custom][:color]}" if theme[:custom][:color]
              custom_styles << "--tooltip-bg-color: #{theme[:custom][:background]}" if theme[:custom][:background]
              wrapper_data[:tooltip_custom_style_value] = custom_styles.join(";")
            end

            options[:data][:tooltip_target] = "trigger"
            options[:aria] ||= {}
            options[:aria][:describedby] = "tooltip-#{SecureRandom.hex(4)}"
          end

          private

          def normalize_tooltip_options(options)
            if options.is_a?(String)
              {
                content: options,
                position: "top",
                align: "center",
                trigger: "hover",
                delay: { show: 0, hide: 0 },
                offset: 8,
                theme: "light",
                size: "md",
                arrow: false
              }
            else
              theme = options[:theme]
              theme_data = if theme.is_a?(Hash) && theme[:custom]
                {
                  name: "custom",
                  custom: {
                    color: theme.dig(:custom, :color),
                    background: theme.dig(:custom, :background)
                  }
                }
              else
                { name: theme || "light" }
              end

              {
                content: options[:content],
                position: options[:position] || "top",
                align: options[:align] || "center",
                trigger: options[:trigger] || "hover",
                delay: {
                  show: options.dig(:delay, :show) || 0,
                  hide: options.dig(:delay, :hide) || 0
                },
                offset: options[:offset] || 8,
                theme: theme_data,
                size: options[:size] || "md",
                arrow: options[:arrow] || false
              }
            end
          end
        end
      end
    end
  end
end
