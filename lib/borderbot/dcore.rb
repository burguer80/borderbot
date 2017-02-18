# Welcome to Dcore( Data Sorting Core )
# Here is where all data is sorted.
require "borderbot/hash"

class Dcore

  def initialize
      @ports = []
  end

  def clean_port(port)
    @port = port
    return @port
  end

  def zortificate_ports(bwtXML)
      #bwtXML converted to hash for easy usage
      bwtHASH = Hash.from_xml(bwtXML.to_s)
      for port in bwtHASH[:border_wait_time][:port]
        puts clean_port(port)
        puts '---'
        #TODO implement the dcore sort methods
      end
      return bwtHASH
  end
end
