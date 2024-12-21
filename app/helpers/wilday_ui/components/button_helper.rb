module WildayUi
  module Components
    module ButtonHelper
      BUTTON_FEATURES = {
        dropdown: {
          wrapper_required: true,
          stimulus_controller: "dropdown",
          default_stimulus_action: "click->dropdown#toggle"
        },
        loading: {
          wrapper_required: false,
          stimulus_controller: "button",
          default_stimulus_action: "click->button#toggleLoading"
        },
        copy_to_clipboard: {
          wrapper_required: true,
          stimulus_controller: "clipboard button",
          default_stimulus_action: "click->clipboard#copy click->button#toggleLoading"
        },
        confirm: {
          wrapper_required: true,
          stimulus_controller: "confirmation",
          default_stimulus_action: "click->confirmation#showDialog"
        }
        # Add more features here as needed
        # tooltip: {
        #   wrapper_required: true,
        #   stimulus_controller: "tooltip",
        #   default_stimulus_action: "mouseenter->tooltip#show mouseleave->tooltip#hide"
        # }
      }.freeze

      def w_button(
        content,
        variant: :solid,
        size: :medium,
        radius: :rounded,
        gradient: nil,
        icon: nil,
        icon_position: :left,
        icon_only: false,
        loading: false,
        loading_text: nil,
        disabled: false,
        additional_classes: "",
        use_default_controller: true,
        href: nil,
        method: :get,
        target: nil,
        underline: true,
        dropdown: false,
        dropdown_items: nil,
        dropdown_icon: nil,
        theme: nil,
        copy_to_clipboard: nil,
        confirm: nil,
        **options
      )
        content_for(:head) { stylesheet_link_tag "wilday_ui/components/button/index", media: "all" }

        options[:data] ||= {}
        wrapper_data = {}
        wrapper_options = nil

        # Process gradient styles if present
        if gradient.present?
          gradient_styles = process_gradient(gradient)
          options[:style] = [ options[:style], gradient_styles ].compact.join(";") if gradient_styles.present?
        end

        # Process theme styles
        if theme.present?
          theme_styles = process_theme(variant, theme)
          options[:style] = theme_styles if theme_styles.present?
        end

        variant_class = get_variant_class(variant)
        size_class = get_size_class(size)
        radius_class = get_radius_class(radius)
        gradient_class = get_gradient_class(gradient)

        # Setup features that require Stimulus controllers
        active_features = determine_active_features(loading, dropdown, loading_text, copy_to_clipboard, confirm, use_default_controller)

        setup_features(active_features, options, use_default_controller, loading_text)

        setup_link_options(options, href, target, method)

        if dropdown
          setup_dropdown_options(
            options,
            additional_classes,
            dropdown,
            dropdown_items,
            wrapper_data
          )
        end

        if copy_to_clipboard
          setup_clipboard_options(
            options,
            additional_classes,
            copy_to_clipboard,
            wrapper_data
          )
        end

        if confirm
          setup_confirmation_options(
            options,
            additional_classes,
            confirm,
            wrapper_data
          )
        end

        # Setup wrapper options if any feature requires it
        wrapper_options = setup_wrapper_options(
          active_features,
          additional_classes,
          wrapper_data
        )

        render_button(
          content,
          variant_class,
          size_class,
          radius_class,
          gradient_class,
          icon,
          icon_position,
          icon_only,
          loading,
          loading_text,
          additional_classes,
          disabled,
          options,
          href,
          underline,
          dropdown,
          dropdown_items,
          dropdown_icon,
          wrapper_options
        )
      end

      private

      # def get_variant_class(variant)
      #   {
      #     primary: "w-button-primary",
      #     secondary: "w-button-secondary",
      #     outline: "w-button-outline"
      #   }[variant] || "w-button-primary"
      # end

      def get_variant_class(variant)
        {
          solid: "w-button-solid",
          subtle: "w-button-subtle",
          surface: "w-button-surface",
          outline: "w-button-outline",
          ghost: "w-button-ghost",
          plain: "w-button-plain"
        }[variant] || "w-button-solid"
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

      def get_gradient_class(gradient)
        return nil unless gradient

        if gradient.is_a?(Hash) && gradient[:from] && gradient[:to]
          "w-button-gradient-custom"
        else
          "w-button-gradient-#{gradient}"
        end
      end

      def process_gradient(gradient)
        return nil unless gradient.is_a?(Hash) && gradient[:from] && gradient[:to]

        if gradient[:via]
          "background: linear-gradient(135deg, #{gradient[:from]}, #{gradient[:via]}, #{gradient[:to]})"
        else
          "background: linear-gradient(135deg, #{gradient[:from]}, #{gradient[:to]})"
        end
      end

      def process_theme(variant, theme)
        return nil unless theme[:name] || theme[:custom]

        Rails.logger.debug "[Wilday UI] Processing theme for variant: #{variant}"
        Rails.logger.debug "[Wilday UI] Theme config: #{theme.inspect}"

        styles = {}

        if theme[:name]
          theme_colors = get_theme_colors(variant, theme[:name])
          styles.merge!(theme_colors)
        end

        if theme[:custom]
          custom_styles = process_custom_theme(theme[:custom])
          styles.merge!(custom_styles)
        end

        generate_styles(styles)
      end

      def get_theme_colors(variant, theme_name)
        config = WildayUi::Config::Theme.configuration
        # Convert theme_name to string
        return {} unless config&.colors&.[](theme_name.to_s)

        colors = config.colors[theme_name.to_s]

        case variant
        when :solid
          {
            "--w-button-color": "#FFFFFF",
            "--w-button-bg": colors["500"],
            "--w-button-hover-bg": colors["600"],
            "--w-button-active-bg": colors["700"]
          }
        when :subtle
          {
            "--w-button-color": colors["700"],
            "--w-button-bg": colors["50"],
            "--w-button-hover-bg": colors["100"],
            "--w-button-hover-color": colors["800"]
          }
        when :surface
          {
            "--w-button-color": colors["700"],
            "--w-button-bg": colors["50"],
            "--w-button-hover-bg": colors["100"],
            "--w-button-border": colors["200"],
            "--w-button-hover-border": colors["300"]
          }
        when :outline
          {
            "--w-button-color": colors["600"],
            "--w-button-border": colors["300"],
            "--w-button-hover-bg": colors["50"],
            "--w-button-hover-border": colors["400"],
            "--w-button-hover-color": colors["700"]
          }
        when :ghost
          {
            "--w-button-color": colors["600"],
            "--w-button-hover-bg": colors["50"],
            "--w-button-hover-color": colors["700"]
          }
        when :plain
          {
            "--w-button-color": colors["600"],
            "--w-button-hover-color": colors["700"],
            "--w-button-active-color": colors["800"]
          }
        else
          {}
        end
      end

      def process_custom_theme(custom)
        return {} unless custom

        {
          "--w-button-color": custom[:color],
          "--w-button-bg": custom[:background],
          "--w-button-border": custom[:border],
          "--w-button-hover-color": custom.dig(:hover, :color),
          "--w-button-hover-bg": custom.dig(:hover, :background),
          "--w-button-hover-border": custom.dig(:hover, :border),
          "--w-button-active-color": custom.dig(:active, :color),
          "--w-button-active-bg": custom.dig(:active, :background),
          "--w-button-active-border": custom.dig(:active, :border)
        }.compact
      end

      def generate_styles(styles)
        styles.map { |k, v| "#{k}: #{v}" }.join(";")
      end

      def determine_active_features(loading, dropdown, loading_text = nil, copy_to_clipboard = nil, confirm = nil, use_default_controller = true)
        features = {}
        features[:loading] = true if (loading || loading_text.present?) && use_default_controller
        features[:dropdown] = true if dropdown && use_default_controller
        features[:copy_to_clipboard] = true if copy_to_clipboard.present? && use_default_controller
        features[:confirm] = true if confirm.present? && use_default_controller
        features
      end

      def setup_features(active_features, options, use_default_controller, loading_text)
        return unless use_default_controller && active_features.any?

        active_features.each do |feature, _value|
          feature_config = BUTTON_FEATURES[feature]
          next unless feature_config

          # Skip adding controller for dropdown feature since it's handled by wrapper
          if feature_config[:wrapper_required]
            # For dropdown, only set the action, not the controller
            options[:data][:action] = feature_config[:default_stimulus_action]
          else
            setup_feature_controller(options, feature_config, loading_text)
          end
        end
      end

      def setup_feature_controller(options, feature_config, loading_text)
        options[:data] ||= {}

        existing_controller = options.dig(:data, :controller)
        existing_action = options.dig(:data, :action)

        options[:data][:controller] = [
          existing_controller,
          feature_config[:stimulus_controller]
        ].compact.join(" ")

        options[:data][:action] = [
          existing_action,
          feature_config[:default_stimulus_action]
        ].compact.join(" ")

        # Add feature-specific data attributes
        if feature_config[:stimulus_controller] == "button" && loading_text.present?
          options[:data][:button_loading_text] = loading_text
        end
      end

      def setup_link_options(options, href, target, method)
        return unless href.present?

        options[:href] = href
        options[:target] = target if target
        options[:data][:method] = method if method != :get
        options[:rel] = "noopener noreferrer" if target == "_blank"
      end

      def setup_dropdown_options(options, additional_classes, dropdown, dropdown_items, wrapper_data)
        additional_classes = "#{additional_classes} w-button-dropdown"

        options[:data][:dropdown_target] = "button"

        wrapper_data.merge!(
          controller: "dropdown",
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

      def setup_wrapper_options(active_features, additional_classes, wrapper_data)
        return nil unless needs_wrapper?(active_features)

        {
          class: [ "w-button-wrapper", additional_classes ].compact.join(" "),
          data: wrapper_data,
          role: active_features[:dropdown] ? "menu" : nil
        }.compact
      end

      def needs_wrapper?(active_features)
        active_features.any? { |feature, _| BUTTON_FEATURES[feature][:wrapper_required] }
      end

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

      def setup_clipboard_options(options, additional_classes, copy_to_clipboard, wrapper_data)
        return unless copy_to_clipboard.present?

        clipboard_config = normalize_clipboard_options(copy_to_clipboard)

        wrapper_data.merge!(
          controller: "clipboard button",
          clipboard_text_value: clipboard_config[:text],
          clipboard_feedback_text_value: clipboard_config[:feedback_text],
          clipboard_feedback_position_value: clipboard_config[:position],
          clipboard_feedback_duration_value: clipboard_config[:duration]
        )

        options[:data][:clipboard_target] = "button"
        options[:data][:button_target] = "button"
      end

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

      def setup_confirmation_options(options, additional_classes, confirm, wrapper_data)
        return unless confirm.present?

        confirm_config = normalize_confirmation_options(confirm)

        # Use the same theme processing as regular buttons
        confirm_theme_styles = process_theme(:solid, { name: confirm_config[:variant] })
        cancel_theme_styles = process_theme(:subtle, { name: :secondary })

        wrapper_data.merge!(
          controller: "confirmation",
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

      def render_button(content, variant_class, size_class, radius_class, gradient_class, icon, icon_position, icon_only,
                       loading, loading_text, additional_classes, disabled, options, href, underline,
                       dropdown, dropdown_items, dropdown_icon, wrapper_options)

        render partial: "wilday_ui/button",
          locals: {
            content: content,
            variant_class: variant_class,
            size_class: size_class,
            radius_class: radius_class,
            gradient_class: gradient_class,
            icon: icon,
            icon_position: icon_position,
            icon_only: icon_only,
            loading: loading,
            loading_text: loading_text,
            additional_classes: additional_classes,
            disabled: disabled,
            html_options: options,
            href: href,
            underline: underline,
            dropdown: dropdown,
            dropdown_items: dropdown_items,
            dropdown_icon: dropdown_icon,
            wrapper_options: wrapper_options
          }
      end
    end
  end
end
