module WildayUi
  module Components
    module Button
      module Features
        module Loading
          FEATURE_CONFIG = {
            wrapper_required: false,
            stimulus_controller: "button",
            default_stimulus_action: "click->button#toggleLoading"
          }.freeze

          def self.feature_config
            { loading: FEATURE_CONFIG }
          end

          def setup_loading_options(options, loading_text)
            return unless loading_text.present?

            feature_config = FEATURE_CONFIG
            setup_feature_controller(options, feature_config, loading_text)
          end

          def setup_loading_data_attributes(options, loading_text)
            return unless loading_text.present?
            options[:data] ||= {}
            options[:data][:button_loading_text] = loading_text
          end
        end
      end
    end
  end
end
