module WildayUi
  module Components
    module Button
      module ButtonHelper
        include Features::LoadingHelper
        include Features::DropdownHelper
        include Features::TooltipHelper

        def w_button(
          content,
          variant: :primary,
          size: :medium,
          radius: :rounded,
          icon: nil,
          icon_position: :left,
          disabled: false,
          additional_classes: "",
          href: nil,
          method: :get,
          target: nil,
          **options
        )
          content_for(:head) { stylesheet_link_tag "wilday_ui/components/button/index", media: "all" }

          # Initialize options
          options = initialize_button_options(options)

          # Get base classes
          variant_class = get_variant_class(variant)
          size_class = get_size_class(size)
          radius_class = get_radius_class(radius)

          # Handle link options
          options = prepare_link_options(href, target, method, options)

          render partial: "wilday_ui/components/button/button",
            locals: {
              content: content,
              variant_class: variant_class,
              size_class: size_class,
              radius_class: radius_class,
              icon: icon,
              icon_position: icon_position,
              additional_classes: additional_classes,
              disabled: disabled,
              html_options: options,
              href: href,
              wrapper_options: needs_wrapper?(options) ? prepare_wrapper_options(options) : nil
            }
        end

        private

        # def initialize_button_options(options)
        #   options[:data] ||= {}

        #   # Add base controller and action
        #   options[:data][:controller] = [
        #     options[:data][:controller],
        #     "button"
        #   ].compact.join(" ")

        #   options[:data][:action] = [
        #     options[:data][:action],
        #     "button#click"
        #   ].compact.join(" ")

        #   options
        # end
        def initialize_button_options(options)
          options[:data] ||= {}

          # Extract loading text from options
          loading_text = options.delete(:loading_text)

          # Add base controller and action
          options[:data][:controller] = [
            options[:data][:controller],
            "button",
            (loading_text.present? ? "button-loading" : nil)
          ].compact.join(" ")

          options[:data][:action] = [
            options[:data][:action],
            "button#click",
            (loading_text.present? ? "click->button-loading#toggle" : nil)
          ].compact.join(" ")

          # Add loading text value if present
          if loading_text.present?
            options[:data][:button_loading_text_value] = loading_text
            puts "Setting loading text value: #{loading_text}"
          end

          options
        end

        def get_variant_class(variant)
          {
            primary: "w-button-primary",
            secondary: "w-button-secondary",
            outline: "w-button-outline"
          }[variant] || "w-button-primary"
        end

        def get_size_class(size)
          {
            small: "w-button-small",
            medium: "w-button-medium",
            large: "w-button-large"
          }[size] || "w-button-medium"
        end

        def get_radius_class(radius)
          {
            rounded: "w-button-rounded",
            pill: "w-button-pill",
            square: "w-button-square"
          }[radius] || "w-button-rounded"
        end

        def prepare_link_options(href, target, method, options)
          return options unless href.present?

          options.merge!(
            href: href,
            target: target,
            data: options[:data].merge(
              method: (method unless method == :get)
            ),
            rel: (target == "_blank" ? "noopener noreferrer" : nil)
          ).compact
        end

        def needs_wrapper?(options)
          options.dig(:data, :wrapper_data).present?
        end

        def prepare_wrapper_options(options)
          {
            class: "w-button-wrapper",
            data: options.dig(:data, :wrapper_data)
          }.compact
        end
      end
    end
  end
end
