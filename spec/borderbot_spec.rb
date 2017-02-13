require "spec_helper"

describe Borderbot do
  it "has a version number" do
    expect(Borderbot::VERSION).not_to be nil
  end

  it "All Agent fields are valid" do
    bwt_url = Agent.new.bwt_url
    expect(bwt_url.class).to eq(String)
  end
end
