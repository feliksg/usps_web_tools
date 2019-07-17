require_relative 'response'
require 'forwardable'

module USPSWebTools
  class Responses
    extend Forwardable
    include Enumerable

    def_delegators :@response_objects, :[], :each, :size
    attr_reader :xml

    def initialize(xml:)
      @xml = xml
      @response_objects = response_objects
    end

    def error?
      response_api_signature == 'Error'
    end

    private

    def usps_responses
      @usps_responses ||= (error? ? [] : doc.xpath("//#{response_group}").map(&:to_xml))
    end

    def response_objects
      case response_api_signature
      when 'CityStateLookupResponse'
        usps_responses.map {|response| USPSWebTools::Response::CityStateLookup.new(response: response)}
      when 'AddressValidateResponse'
        usps_responses.map {|response| USPSWebTools::Response::AddressValidate.new(response: response)}
      when 'ZipCodeLookupResponse'
        usps_responses.map {|response| USPSWebTools::Response::ZipCodeLookup.new(response: response)}
      else
        raise USPSWebTools::Error, "Undefined Response API <#{response_api_signature}>!"
      end
    end

    def doc
      @doc ||= Nokogiri::XML.parse(xml)
    end

    def response_api_signature
      doc.child.name
    end

    def response_group
      raise USPSWebTools::ResponseGroupError if error?
      case response_api_signature
      when 'CityStateLookupResponse'
        'ZipCode'
      when 'AddressValidateResponse'
        'Address'
      when 'ZipCodeLookupResponse'
        'Address'
      else
        raise USPSWebTools::Error, "Undefined Response API <#{response_api_signature}>!"
      end
    end
  end
end
