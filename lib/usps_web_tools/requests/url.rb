module USPSWebTools
  class Requests
    class URL
      attr_accessor :secure
      PATH = '/ShippingAPI.dll?'
      XML_PREFIX = '&XML='

      def initialize(secure: true)
        @secure = secure
      end

      def encoded_url(xml:)
        URI.encode(request_api_signature(xml))
      end

      private

      def request_api_signature(xml)
        doc = Nokogiri::XML.parse(xml)
        base = [scheme, host, PATH, "API=#{url_api(request_api(doc))}", XML_PREFIX].join
        [base, xml].join
      end

      def request_api(doc)
        doc.child.name
      end

      def url_api(request_api)
        case request_api
        when 'AddressValidateRequest'
          'Verify'
        when 'CityStateLookupRequest'
          'CityStateLookup'
        when 'ZipCodeLookupRequest'
          'ZipCodeLookup'
        else
          raise USPSWebTools::Error, "Undefined Request API #{request_api}!"
        end
      end

      def scheme
        secure ? 'https://' : 'http://'
      end

      def host
        secure ? 'secure.shippingapis.com' : 'production.shippingapis.com'
      end
    end
  end
end