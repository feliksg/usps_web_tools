require 'nokogiri'
require_relative 'usps_web_tools/parameter'
require_relative 'usps_web_tools/requests'
require_relative 'usps_web_tools/responses'
require_relative 'usps_web_tools/version'

module USPSWebTools
  class Error < StandardError;
  end

  class ResponseGroupError < StandardError
    def initialize(msg = nil)
      @message = msg || ("Submission Group Error. If you submitted more than 1 request in the bundle, " +
          "you will need to submit your requests separately!")
    end
  end
end
