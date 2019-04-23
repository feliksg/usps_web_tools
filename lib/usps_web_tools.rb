require 'nokogiri'
require_relative 'usps_web_tools/parameter'
require_relative 'usps_web_tools/requests'
require_relative 'usps_web_tools/responses'
require_relative 'usps_web_tools/version'

module USPSWebTools
  class Error < StandardError; end
end
