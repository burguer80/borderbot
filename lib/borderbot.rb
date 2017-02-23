require "borderbot/version"
require "borderbot/agent"

module Borderbot
  def self.go
    Agent.new
  end
end
