module USPSWebTools
  module Response
    class AddressValidate
      include Response
      attr_reader :response

      def initialize(response:)
        @response = response
      end

      def deliverable?
        valid? && !vacant? && return_text.nil?
      end

      def vacant?
        vacant == 'Y'
      end

      def business?
        business == 'Y'
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

      def city_abbreviation
        node.xpath('.//CityAbbreviation').map(&:text).first
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

      def delivery_point
        node.xpath('.//DeliveryPoint').map(&:text).first
      end

      def dpv_confirmation
        node.xpath('.//DPVConfirmation').map(&:text).first
      end

      def dpv_cmra
        node.xpath('.//DPVCMRA').map(&:text).first
      end

      def dpv_footnotes
        node.xpath('.//DPVFootnotes').map(&:text).first
      end

      def business
        node.xpath('.//Business').map(&:text).first
      end

      def carrier_route
        node.xpath('.//CarrierRoute').map(&:text).first
      end

      def central_delivery_point
        node.xpath('.//CentralDeliveryPoint').map(&:text).first
      end

      def vacant
        node.xpath('.//Vacant').map(&:text).first
      end

      def return_text
        node.xpath('.//ReturnText').map(&:text).first
      end

      def address
        @address ||= begin
          USPSWebTools::Parameter::Address.new(id: id, addr1: addr1, addr2: addr2, city: city, state: state, zip5: zip5, zip4: zip4) if valid?
        end
      end
    end
  end
end
