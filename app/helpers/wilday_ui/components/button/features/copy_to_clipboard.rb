module WildayUi
  module Components
    module Button
      module Features
        module CopyToClipboard
          FEATURE_CONFIG = {
            wrapper_required: true,
            stimulus_controller: "clipboard button",
            default_stimulus_action: "click->clipboard#copy click->button#toggleLoading"
          }.freeze

          def self.feature_config
            { copy_to_clipboard: FEATURE_CONFIG }
          end

          def setup_clipboard_options(options, additional_classes, copy_to_clipboard, wrapper_data)
            return unless copy_to_clipboard.present?

            clipboard_config = normalize_clipboard_options(copy_to_clipboard)

            wrapper_data.merge!(
              controller: FEATURE_CONFIG[:stimulus_controller],
              clipboard_text_value: clipboard_config[:text],
              clipboard_feedback_text_value: clipboard_config[:feedback_text],
              clipboard_feedback_position_value: clipboard_config[:position],
              clipboard_feedback_duration_value: clipboard_config[:duration]
            )

            options[:data][:clipboard_target] = "button"
            options[:data][:button_target] = "button"
          end

          private

          def normalize_clipboard_options(options)
            if options.is_a?(Hash)
              {
                text: options[:text],
                feedback_text: options[:feedback_text] || "Copied!",
                position: options[:position] || "top",
                duration: options[:duration] || 2000
              }
            else
              {
                text: options.to_s,
                feedback_text: "Copied!",
                position: "top",
                duration: 2000
              }
            end
          end
        end
      end
    end
  end
end
