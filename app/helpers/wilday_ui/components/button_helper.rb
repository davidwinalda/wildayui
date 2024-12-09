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
        disabled: false,
        additional_classes: "",
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

        render partial: "wilday_ui/button",
          locals: {
            content: content,
            variant_class: variant_class,
            size_class: size_class,
            radius_class: radius_class,
            icon: icon,
            icon_position: icon_position,
            additional_classes: additional_classes,
            disabled: disabled,
            attributes: options.map { |key, value| "#{key}='#{value}'" }.join(" ")
          }
      end
    end
  end
end
