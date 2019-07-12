module USPSWebTools
  module Response
    def error?
      !valid?
    end

    def valid?
      error.empty?
    end

    def to_s
      node.to_xml
    end

    def name
      node.name
    end

    def id
      node.xpath('.//Address').attr('ID').value
    end

    def error
      node.xpath('.//Error')
    end

    def error_descriptions
      error? ? node.xpath('.//Description').map(&:text) : []
    end

    def node
      @node ||= Nokogiri::XML.parse(response)
    end

    def response
      raise NotImplementedError
    end

    def method_missing(mth, *args, &block)
      raise NoMethodError, "#{self.class} has no `#{mth}' method!"
    end
  end
end

require_relative 'response/address_validate'
require_relative 'response/city_state_lookup'
require_relative 'response/zip_code_lookup'
