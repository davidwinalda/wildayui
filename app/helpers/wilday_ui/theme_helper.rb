module WildayUi
  module ThemeHelper
    def generate_theme_css_variables
      colors = WildayUi::Config::Theme.configuration.colors
      css_vars = colors.map do |color_name, shades|
        shades.map do |shade, value|
          "--w-color-#{color_name}-#{shade}: #{value};"
        end
      end.flatten.join("\n")

      "<style>:root { #{css_vars} }</style>".html_safe
    end

    # Helper to get specific color value
    def theme_color(name, shade = "500")
      WildayUi::Config::Theme.configuration.colors.dig(name.to_s, shade.to_s)
    end
  end
end
