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
    end
  end
end
