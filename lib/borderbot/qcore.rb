# Welcome to Qcore(Query Core)
require 'nokogiri'
require 'open-uri'
require 'json'
require "borderbot/dcore"
require "byebug"

class Qcore
    attr_accessor :bwt_url

    def initialize
      @bwt_url = 'https://bwt.cbp.gov/xml/bwt.xml'
      @historical_bwt_url = 'https://bwt.cbp.gov/api/historicalwaittimes/06240202/POV/GEN/1/7'
    end

    def get_bwt_xml_data
      bwtXML = Nokogiri::XML(open("https://bwt.cbp.gov/xml/bwt.xml"))
      return bwtXML
    end

    def extract_ports(bwtXML)
      ports = Dcore.new.zortificate_ports(bwtXML)
      return ports
    end

    def get_historical_data(port_number, month, day_of_the_week, time_slot)
      bwtJSON = JSON.load(open("https://bwt.cbp.gov/api/historicalwaittimes/#{port_number}/POV/GEN/#{month}/7"))
      historical_data = Dcore.new.get_wait_times_on_day_and_time(bwtJSON, day_of_the_week, time_slot)
      return bwtJSON
    end

end
