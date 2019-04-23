require_relative 'requests/url'

module USPSWebTools
  class Requests
    attr_reader :user_id, :password, :api, :revision, :parameters

    MAX = 5

    def initialize(user_id:, password:, api:, app_id: nil, revision: 1, parameters: [])
      raise USPSWebTools::Error, "Cannot have more than #{MAX} parameters" if parameters.size > MAX
      @user_id = user_id
      @password = password
      @api = api
      @app_id = app_id
      @revision = revision
      @parameters = parameters
    end

    def to_url
      USPSWebTools::Requests::URL.new.encoded_url(xml: to_xml)
    end

    def to_xml
      doc.root.to_xml
    end

    alias_method :to_s, :to_xml
    alias_method :string, :to_xml
    alias_method :to_str, :to_xml

    private

    def doc
      @doc ||= begin
        _doc = builder.doc
        node_set = Nokogiri::XML::NodeSet.new(_doc)
        @parameters.each do |parameter|
          node = parameter.node
          node_set << node
        end
        rev = _doc.at_css('Revision')
        rev.add_next_sibling(node_set)
        _doc
      end
    end

    def builder
      @builder ||= begin
        Nokogiri::XML::Builder.new do |xml|
          xml.send(@api, 'USERID' => @user_id) do
            xml.Revision @revision
          end
        end
      end
    end
  end
end