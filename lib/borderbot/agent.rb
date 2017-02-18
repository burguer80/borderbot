# Welcome to the Agent Class
# this is a a clone of a Borderbot
# it will obbey ruby programmers.

require "borderbot/qcore"

class Agent
  attr_reader :bwt_url, :executed_at, :ports

  def initialize
      @bwt_url = Qcore.new.bwt_url
      @ports = nil
      @executed_at = nil
      compute
  end

  def compute
    #New Query Core instance
    queryCore  = Qcore.new
    #Get XML data from BWT website
    bwtXML = queryCore.get_bwt_xml_data
    #set the ordereded ports into @ports
    @ports = queryCore.extract_ports(bwtXML)
    #set the last execution time
    @executed_at = DateTime.now
  end


end
