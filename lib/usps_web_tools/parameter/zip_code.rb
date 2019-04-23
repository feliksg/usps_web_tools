module USPSWebTools
  module Parameter
    class ZipCode
      include USPSWebTools::Parameter
      attr_reader :id, :zip5

      def initialize(id:, zip5: nil)
        @id = id
        @zip5 = zip5
      end

      def builder
        Nokogiri::XML::Builder.new do |xml|
          xml.ZipCode('ID' => id) do
            xml.Zip5 zip5
          end
        end
      end
    end
  end
end