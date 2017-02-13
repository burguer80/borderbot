# Welcome to Qcore(Query Core)
require 'nokogiri'
require 'open-uri'
require "borderbot/dcore"
require "borderbot/hash"

class Qcore
    attr_accessor :bwt_url

    def initialize
      @bwt_url = 'https://apps.cbp.gov/bwt/bwt.xml'
    end

    def get_bwt_xml_data
      bwtXML = Nokogiri::XML(open("https://apps.cbp.gov/bwt/bwt.xml"))
      return bwtXML
    end

end
