# Welcome to the Agent Class
# this is a a clone of a Borderbot
# it will obbey ruby programmers.

require "borderbot/qcore"
class Agent
  attr_reader :bwt_url

  def initialize
      @bwt_url = Qcore.new.bwt_url
  end


end
