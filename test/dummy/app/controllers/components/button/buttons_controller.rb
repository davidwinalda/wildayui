module Components
  module Button
    class ButtonsController < ApplicationController
      def index
        render "components/button/index"
      end

      def variant
        render "components/button/variant"
      end

      def icon
        render "components/button/icon"
      end

      def size
        render "components/button/size"
      end

      def radius
        render "components/button/radius"
      end

      def link
        render "components/button/link"
      end

      def loading
        render "components/button/loading"
      end

      def dropdown
        render "components/button/dropdown"
      end

      def gradient
        render "components/button/gradient"
      end

      def clipboard
        render "components/button/clipboard"
      end

      def confirmation
        render "components/button/confirmation"
      end
    end
  end
end
