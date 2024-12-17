# lib/wilday_ui/config/theme.rb
module WildayUi
  module Config
    class Theme
      class << self
        attr_accessor :configuration
      end

      def self.configure
        self.configuration ||= Configuration.new
        yield(configuration) if block_given?
      end

      class Configuration
        attr_accessor :colors

        def initialize
          @colors = default_colors
        end

        private

        def default_colors
          {
            "primary" => {
              "50" => "#E5F0FF",
              "100" => "#CCE0FF",
              "200" => "#99C2FF",
              "300" => "#66A3FF",
              "400" => "#3385FF",
              "500" => "#0066FF",
              "600" => "#0052CC",
              "700" => "#003D99",
              "800" => "#002966",
              "900" => "#001433"
            },
            "secondary" => {
              "50" => "#F8F9FA",
              "100" => "#E9ECEF",
              "200" => "#DEE2E6",
              "300" => "#CED4DA",
              "400" => "#ADB5BD",
              "500" => "#6C757D",
              "600" => "#5A6268",
              "700" => "#495057",
              "800" => "#343A40",
              "900" => "#212529"
            },
            "success" => {
              "50" => "#ECFDF5",
              "100" => "#D1FAE5",
              "200" => "#A7F3D0",
              "300" => "#6EE7B7",
              "400" => "#34D399",
              "500" => "#10B981",
              "600" => "#059669",
              "700" => "#047857",
              "800" => "#065F46",
              "900" => "#064E3B"
            },
            "danger" => {
              "50" => "#FEE2E2",
              "100" => "#FECACA",
              "200" => "#FCA5A5",
              "300" => "#F87171",
              "400" => "#EF4444",
              "500" => "#DC2626",
              "600" => "#B91C1C",
              "700" => "#991B1B",
              "800" => "#7F1D1D",
              "900" => "#450A0A"
            },
            "warning" => {
              "50" => "#FFFBEB",
              "100" => "#FEF3C7",
              "200" => "#FDE68A",
              "300" => "#FCD34D",
              "400" => "#FBBF24",
              "500" => "#F59E0B",
              "600" => "#D97706",
              "700" => "#B45309",
              "800" => "#92400E",
              "900" => "#78350F"
            },
            "info" => {
              "50" => "#EFF6FF",
              "100" => "#DBEAFE",
              "200" => "#BFDBFE",
              "300" => "#93C5FD",
              "400" => "#60A5FA",
              "500" => "#3B82F6",
              "600" => "#2563EB",
              "700" => "#1D4ED8",
              "800" => "#1E40AF",
              "900" => "#1E3A8A"
            },
            "light" => {
              "50" => "#FFFFFF",
              "100" => "#F8F9FA",
              "200" => "#F1F3F5",
              "300" => "#E9ECEF",
              "400" => "#DEE2E6",
              "500" => "#CED4DA",
              "600" => "#ADB5BD",
              "700" => "#868E96",
              "800" => "#495057",
              "900" => "#212529"
            },
            "dark" => {
              "50" => "#F9FAFB",
              "100" => "#F3F4F6",
              "200" => "#E5E7EB",
              "300" => "#D1D5DB",
              "400" => "#9CA3AF",
              "500" => "#1F2937",
              "600" => "#111827",
              "700" => "#374151",
              "800" => "#1F2937",
              "900" => "#111827"
            },
            "link" => {
              "50" => "#EFF6FF",
              "100" => "#DBEAFE",
              "200" => "#BFDBFE",
              "300" => "#93C5FD",
              "400" => "#60A5FA",
              "500" => "#2563EB",
              "600" => "#1D4ED8",
              "700" => "#1E40AF",
              "800" => "#1E3A8A",
              "900" => "#1E3A8A"
            }
          }
        end
      end
    end
  end
end
