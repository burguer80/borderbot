# Welcome to Qcore(Query Core)
require 'nokogiri'
require 'open-uri'
require "borderbot/dcore"

class Qcore
    attr_accessor :bwt_url

    def initialize
      @bwt_url = 'https://apps.cbp.gov/bwt/bwt.xml'
    end

    def get_bwt_xml_data
      bwtXML = Nokogiri::XML(open("https://apps.cbp.gov/bwt/bwt.xml"))
      return bwtXML
    end

    def extract_ports(bwtXML)
      ports = Dcore.new.zortificate_ports(bwtXML)

      return ports
    end

end
