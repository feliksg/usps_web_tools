require_relative 'parameter/address'
require_relative 'parameter/zip_code'

module USPSWebTools
  module Parameter

    def root_node
      builder.doc.root
    end

    alias_method :node, :root_node

    def to_xml
      node.to_xml
    end

    alias_method :to_s, :to_xml
    alias_method :to_str, :to_s

    def name
      root_node.name
    end

    private

    def builder
      raise NotImplementedError
    end
  end
end
