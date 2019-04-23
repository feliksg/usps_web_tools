module USPSWebTools
  module Response
    class ZipCodeLookup
      include Response
      attr_reader :response

      def initialize(response:)
        @response = response
      end

      def formatted_address
        address.formatted_address if address
      end

      def firm_name
        node.xpath('.//FirmName').map(&:text).first
      end

      def addr1
        node.xpath('.//Address2').map(&:text).first
      end

      def addr2
        node.xpath('.//Address1').map(&:text).first
      end

      def city
        node.xpath('.//City').map(&:text).first
      end

      def state
        node.xpath('.//State').map(&:text).first
      end

      def zip5
        node.xpath('.//Zip5').map(&:text).first
      end

      def zip4
        node.xpath('.//Zip4').map(&:text).first
      end

      private

      def address
        if valid?
          USPSWebTools::Parameter::Address.new(id: id, firm_name: firm_name, addr1: addr1, addr2: addr2, city: city, state: state, zip5: zip5, zip4: zip4)
        end
      end
    end
  end
end