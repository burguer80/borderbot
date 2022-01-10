require "borderbot/version"
require "borderbot/agent"

module Borderbot
  def self.go
    Agent.new
  end

  def self.historian(port_number, month, day_of_the_week, time_of_day)
    # "06240202", "1", "6", "0"
    agent = Agent.new
    historical_data = agent.get_historical_bwt(port_number, month, day_of_the_week, time_of_day)
    return historical_data
    # historical_data = queryCore.get_historical_data("06240202", "1", "7")
  end
end
