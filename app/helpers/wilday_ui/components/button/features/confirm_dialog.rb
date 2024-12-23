module WildayUi
  module Components
    module Button
      module Features
        module ConfirmDialog
          FEATURE_CONFIG = {
            wrapper_required: true,
            stimulus_controller: "confirmation",
            default_stimulus_action: "click->confirmation#showDialog"
          }.freeze

          def self.feature_config
            { confirm: FEATURE_CONFIG }
          end

          def setup_confirmation_options(options, additional_classes, confirm, wrapper_data)
            return unless confirm.present?

            confirm_config = normalize_confirmation_options(confirm)

            # Use the same theme processing as regular buttons
            confirm_theme_styles = process_theme(:solid, { name: confirm_config[:variant] })
            cancel_theme_styles = process_theme(:subtle, { name: :secondary })

            wrapper_data.merge!(
              controller: FEATURE_CONFIG[:stimulus_controller],
              confirmation_title_value: confirm_config[:title],
              confirmation_message_value: confirm_config[:message],
              confirmation_icon_color_value: confirm_config[:variant],
              confirmation_confirm_text_value: confirm_config[:confirm_text],
              confirmation_cancel_text_value: confirm_config[:cancel_text],
              confirmation_confirm_styles_value: confirm_theme_styles,
              confirmation_cancel_styles_value: cancel_theme_styles
            )

            # Only add loading state if enabled
            if confirm_config[:loading]
              wrapper_data.merge!(
                confirmation_loading_value: "true",
                confirmation_loading_text_value: confirm_config[:loading_text]
              )
            end
          end

          def normalize_confirmation_options(options)
            if options.is_a?(String)
              {
                title: "Confirm Action",
                message: options,
                variant: :info,
                confirm_text: "Confirm",
                cancel_text: "Cancel"
              }
            else
              {
                title: options[:title] || "Confirm Action",
                message: options[:message],
                variant: options[:variant] || :info,
                confirm_text: options[:confirm_text] || "Confirm",
                cancel_text: options[:cancel_text] || "Cancel",
                loading: options[:loading] || false,
                loading_text: options[:loading_text] || "Processing..."
              }
            end
          end
        end
      end
    end
  end
end
