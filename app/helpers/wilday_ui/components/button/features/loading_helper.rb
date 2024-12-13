module WildayUi
  module Components
    module Button
      module Features
        module LoadingHelper
          def w_button(content, loading: false, loading_text: nil, **options)
            return super(content, **options) unless loading || loading_text

            options = prepare_loading_options(options, loading, loading_text)
            super(content, **options)
          end

          private

          def prepare_loading_options(options, loading, loading_text)
            options[:data] ||= {}

            # Add controller
            options[:data][:controller] = [
              options[:data][:controller],
              "button-loading"
            ].compact.join(" ")

            # Set loading text value
            if loading_text.present?
              options[:data][:button_loading_text_value] = loading_text
            end

            # Set loading state
            if loading
              options[:disabled] = true
              options["aria-busy"] = true
              options["aria-disabled"] = true
              options[:data][:loading] = "true"
              options[:data][:button_loading_text_value] ||= "Loading..."
            else
              # Add click action only for non-loading buttons
              options[:data][:action] = [
                options[:data][:action],
                "click->button-loading#toggle"
              ].compact.join(" ")
            end

            options
          end
        end
      end
    end
  end
end
