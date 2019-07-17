module USPSWebTools
  module Response
    class Error
      include Response
      attr_reader :response

      def initialize(response:)
        @response = response
      end

      def description
        node.xpath('.//Description').map(&:text).first
      end

      def source
        node.xpath('.//Source').map(&:text).first
      end

      def number
        node.xpath('.//Number').map(&:text).first
      end

      alias_method :id, :number

      private

    end
  end
end