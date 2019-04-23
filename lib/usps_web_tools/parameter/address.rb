module USPSWebTools
  module Parameter
    class Address
      include USPSWebTools::Parameter
      attr_reader :id, :firm_name, :addr1, :addr2, :city, :state, :urbanization, :zip5, :zip4

      def initialize(id:, firm_name: nil, addr1: nil, addr2: nil,
                     city: nil, state: nil, urbanization: nil,
                     zip5: nil, zip4: nil)
        @id = id
        @firm_name = firm_name
        @addr1 = addr1
        @addr2 = addr2
        @city = city
        @state = state
        @urbanization = urbanization
        @zip5 = zip5
        @zip4 = zip4
      end

      def formatted_address
        [addr1, addr2, "#{city}, #{state} #{zipcode}"].delete_if(&:nil?).delete_if(&:empty?).join("\n")
      end

      private

      def zipcode
        [zip5, zip4].delete_if(&:nil?).join('-')
      end

      def builder
        Nokogiri::XML::Builder.new do |xml|
          xml.Address('ID' => id) do
            xml.FirmName firm_name
            xml.Address1 addr1
            xml.Address2 addr2
            xml.City city
            xml.State state
            xml.Urbanization urbanization
            xml.Zip5 zip5
            xml.Zip4 zip4
          end
        end
      end
    end
  end
end