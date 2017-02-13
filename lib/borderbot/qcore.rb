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

    def zortificate(bwtXML)
      #bwtXML converted to hash for easy usage
      bwtHASH = Hash.from_xml(bwtXML.to_s)

      for port in bwtHASH[:border_wait_time][:port]
        #puts port[:port_name]
        #TODO implement the dcore sort methods
      end

      return bwtHASH
    end

end
