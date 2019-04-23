module USPSWebTools
  module Response
    class CityStateLookup
      include Response
      attr_reader :response

      def initialize(response:)
        @response = response
      end

      def zip5
        node.xpath('.//Zip5').map(&:text).first
      end

      def city
        node.xpath('.//City').map(&:text).first
      end

      def state
        node.xpath('.//State').map(&:text).first
      end

      def finance_number
        node.xpath('.//FinanceNumber').map(&:text).first
      end

      def classification_code
        node.xpath('.//ClassificationCode').map(&:text).first
      end
    end
  end
end
