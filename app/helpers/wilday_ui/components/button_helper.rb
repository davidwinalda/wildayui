module WildayUi
  module Components
    module ButtonHelper
      def w_button(
        content,
        variant: :primary,
        size: :medium,
        radius: :rounded,
        icon: nil,
        icon_position: :left,
        loading: false,
        loading_text: nil,
        disabled: false,
        additional_classes: "",
        use_default_controller: true,
        href: nil, # href parameter
        method: :get, # method parameter
        target: nil, # target parameter
        **options
      )
        content_for(:head) { stylesheet_link_tag "wilday_ui/button", media: "all" }
        variant_class = {
          primary: "w-button-primary",
          secondary: "w-button-secondary",
          outline: "w-button-outline"
        }[variant] || "w-button-primary"

        size_class = {
          small: "w-button-small",
          medium: "w-button-medium",
          large: "w-button-large"
        }[size] || "w-button-medium"

        radius_class = {
          rounded: "w-button-rounded",
          pill: "w-button-pill",
          square: "w-button-square"
        }[radius] || "w-button-rounded"

        # Only add default Stimulus controller if requested and no custom controller specified
        if use_default_controller && !options.dig(:data, :controller) && loading_text.present?
          options[:data] ||= {}
          options[:data][:controller] = "button"
          options[:data][:action] = "click->button#toggleLoading"
          options[:data][:button_loading_text] = loading_text
        end

        # Link specific options
        if href.present?
          options[:href] = href
          options[:target] = target if target
          options[:data] ||= {}
          options[:data][:method] = method if method != :get
          options[:rel] = "noopener noreferrer" if target == "_blank"
        end

        render partial: "wilday_ui/button",
          locals: {
            content: content,
            variant_class: variant_class,
            size_class: size_class,
            radius_class: radius_class,
            icon: icon,
            icon_position: icon_position,
            loading: loading,
            loading_text: loading_text,
            additional_classes: additional_classes,
            disabled: disabled,
            html_options: options,
            href: href
          }
      end
    end
  end
end
