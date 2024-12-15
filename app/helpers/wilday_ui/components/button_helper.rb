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
        href: nil,
        method: :get,
        target: nil,
        dropdown: false,
        dropdown_items: nil,
        dropdown_icon: nil,
        **options
      )
        content_for(:head) { stylesheet_link_tag "wilday_ui/button", media: "all" }

        options[:data] ||= {}
        wrapper_data = {}
        wrapper_options = nil

        variant_class = get_variant_class(variant)
        size_class = get_size_class(size)
        radius_class = get_radius_class(radius)

        # Setup features that require Stimulus controllers
        active_features = determine_active_features(loading, dropdown, loading_text, use_default_controller)

        Rails.logger.debug "Active Features: #{active_features.inspect}"
        Rails.logger.debug "Options before setup: #{options.inspect}"

        setup_features(active_features, options, use_default_controller, loading_text)

        Rails.logger.debug "Options after setup: #{options.inspect}"

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
          icon,
          icon_position,
          loading,
          loading_text,
          additional_classes,
          disabled,
          options,
          href,
          dropdown,
          dropdown_items,
          dropdown_icon,
          wrapper_options
        )
      end

      private

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

      def determine_active_features(loading, dropdown, loading_text = nil, use_default_controller = true)
        features = {}
        features[:loading] = true if (loading || loading_text.present?) && use_default_controller
        features[:dropdown] = true if dropdown && use_default_controller
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

      def render_button(content, variant_class, size_class, radius_class, icon, icon_position,
                       loading, loading_text, additional_classes, disabled, options, href,
                       dropdown, dropdown_items, dropdown_icon, wrapper_options)
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
            href: href,
            dropdown: dropdown,
            dropdown_items: dropdown_items,
            dropdown_icon: dropdown_icon,
            wrapper_options: wrapper_options
          }
      end
    end
  end
end
