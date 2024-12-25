module WildayUi
  module Components
    module Button
      module Features
        module Animation
          FEATURE_CONFIG = {
            wrapper_required: false,
            stimulus_controller: "animation",
            default_stimulus_action: "animation#animate animation#disableAfterAnimation"
          }.freeze

          def self.feature_config
            { animation: FEATURE_CONFIG }
          end

          def setup_animation_options(options, additional_classes, animation, wrapper_data)
            return unless animation.present?

            animation_config = normalize_animation_options(animation)

            # Add animation data attributes
            options[:data] ||= {}
            options[:data][:animation] = animation_config.to_json
            options[:data][:controller] = "animation"
            options[:data][:animation_target] = "button"
            options[:data][:action] = FEATURE_CONFIG[:default_stimulus_action]

            additional_classes = [
              additional_classes,
              "w-button-animated",
              "w-button-animation-#{animation_config[:name]}",
              "w-button-animation-trigger-#{animation_config[:trigger]}"
            ].compact.join(" ")
          end

          private

          def normalize_animation_options(options)
            if options.is_a?(Symbol)
              {
                name: options,
                trigger: :hover,
                timing: :ease,
                duration: 0.3,
                iteration: 1,
                direction: :normal,
                fill_mode: :none,
                disabled: false
              }
            else
              config = {
                name: options[:name]&.to_sym,
                trigger: options[:trigger]&.to_sym || :hover,
                timing: normalize_timing(options[:timing]),
                direction: options[:direction]&.to_sym || :normal,
                iteration: normalize_iteration(options[:iteration]),
                fill_mode: options[:fill_mode]&.to_sym || :none,
                duration: options[:duration] || 0.3,
                delay: options[:delay] || 0,
                disabled: options[:disabled] || false
              }

              # Handle properties based on animation type
              if options[:properties]
                if config[:name] == :custom
                  config[:properties] = options[:properties]  # Pass through all properties for custom animations
                elsif config[:timing] == :cubic_bezier
                  config[:properties] = { cubic_bezier: options[:properties][:cubic_bezier] }  # Handle cubic-bezier timing
                end
              end

              config.compact
            end
          end

          def normalize_timing(timing)
            return :ease unless timing

            timing = timing.to_sym if timing.is_a?(String)
            case timing
            when :linear, :ease, :ease_in, :ease_out, :ease_in_out, :cubic_bezier
              timing
            else
              :ease # default if invalid timing provided
            end
          end

          def normalize_iteration(value)
            return value if value.is_a?(Integer)
            return :infinite if value.to_s.downcase == "infinite"
            value&.to_sym
          end
        end
      end
    end
  end
end
