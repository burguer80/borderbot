require "spec_helper"

describe Borderbot do
  it "has a version number" do
    expect(Borderbot::VERSION).not_to be nil
  end

  it "Agent instance created succesfully" do
    agent = Agent.new
    expect(agent.class).to eq(Agent)
    expect(agent.bwt_url.class).to eq(String)
    expect(agent.ports.class).to eq(NilClass)
    expect(agent.executed_at.class).to eq(NilClass)
  end

end
