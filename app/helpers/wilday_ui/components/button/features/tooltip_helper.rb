module WildayUi
  module Components
    module Button
      module Features
        module TooltipHelper
          def w_button(content, tooltip: nil, tooltip_position: :top, **options)
            return super unless tooltip

            options = prepare_tooltip_options(options, tooltip, tooltip_position)
            super(content, **options)
          end

          private

          def prepare_tooltip_options(options, text, position)
            options[:data] ||= {}
            options[:data][:button_tooltip_target] = "button"
            options[:data][:action] = [
              options[:data][:action],
              "mouseenter->button-tooltip#show",
              "mouseleave->button-tooltip#hide"
            ].compact.join(" ")

            # Set wrapper data
            options[:data][:wrapper_data] = {
              controller: "button-tooltip",
              button_tooltip_text_value: text,
              button_tooltip_position_value: position
            }

            options
          end
        end
      end
    end
  end
end
