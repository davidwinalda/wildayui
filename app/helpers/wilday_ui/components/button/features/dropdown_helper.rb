module WildayUi
  module Components
    module Button
      module Features
        module DropdownHelper
          def w_button(content, dropdown: false, dropdown_items: nil, dropdown_icon: nil, **options)
            return super unless dropdown

            options = prepare_dropdown_options(options, dropdown, dropdown_items, dropdown_icon)
            super(content, **options)
          end

          private

          def prepare_dropdown_options(options, dropdown, items, icon)
            options[:data] ||= {}
            options[:additional_classes] = "#{options[:additional_classes]} w-button-dropdown"

            # Button attributes
            options[:data][:button_dropdown_target] = "button"
            options[:data][:action] = [
              options[:data][:action],
              "click->button-dropdown#toggle"
            ].compact.join(" ")
            options["aria-expanded"] = "false"
            options["aria-haspopup"] = "true"

            # Dropdown configuration
            if dropdown.is_a?(Hash)
              options[:data][:button_dropdown_trigger_value] = dropdown[:trigger] || "click"
              options[:data][:button_dropdown_position_value] = dropdown[:position] || "bottom"
              options[:data][:button_dropdown_align_value] = dropdown[:align] || "start"
            end

            # Add items and icon
            options[:dropdown_items] = items
            options[:dropdown_icon] = icon

            # Set wrapper data
            options[:data][:wrapper_data] = {
              controller: "button-dropdown"
            }

            options
          end
        end
      end
    end
  end
end
