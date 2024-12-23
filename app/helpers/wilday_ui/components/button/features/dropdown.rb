module WildayUi
  module Components
    module Button
      module Features
        module Dropdown
          FEATURE_CONFIG = {
            wrapper_required: true,
            stimulus_controller: "dropdown",
            default_stimulus_action: "click->dropdown#toggle"
          }.freeze

          def self.feature_config
            { dropdown: FEATURE_CONFIG }
          end

          def setup_dropdown_options(options, additional_classes, dropdown, dropdown_items, wrapper_data)
            additional_classes = "#{additional_classes} w-button-dropdown"

            options[:data][:dropdown_target] = "button"

            wrapper_data.merge!(
              controller: FEATURE_CONFIG[:stimulus_controller],
              dropdown_id: "dropdown-#{SecureRandom.hex(4)}"
            )

            if dropdown.is_a?(Hash)
              wrapper_data.merge!(
                dropdown_position_value: dropdown[:position]&.to_s || "bottom",
                dropdown_align_value: dropdown[:align]&.to_s || "start",
                dropdown_trigger_value: dropdown[:trigger]&.to_s || "click"
              )
            else
              wrapper_data.merge!(
                dropdown_position_value: "bottom",
                dropdown_align_value: "start",
                dropdown_trigger_value: "click"
              )
            end

            normalize_dropdown_items(dropdown_items)
          end

          private

          def normalize_dropdown_items(items, parent_id = nil)
            return [] unless items

            items.map.with_index do |item, index|
              item_id = generate_item_id(parent_id, index)

              normalized_item = {
                id: item_id,
                text: item[:text],
                href: item[:href],
                divider: item[:divider]
              }

              if item[:children].present?
                normalized_item[:children] = normalize_dropdown_items(item[:children], item_id)
              end

              normalized_item.compact
            end
          end

          def generate_item_id(parent_id, index)
            base = parent_id ? "#{parent_id}-" : "dropdown-item-"
            "#{base}#{index}"
          end
        end
      end
    end
  end
end
