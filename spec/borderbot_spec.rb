require "spec_helper"

describe Borderbot do
  it "has a version number" do
    expect(Borderbot::VERSION).not_to be nil
  end
  
  it "Agent init" do
   #code
   a = Agent.new
   expect(a).not_to be nil
  end

  it "BWT XML url is present" do
   #code
   queryCore  = Qcore.new
   expect(queryCore.bwt_url).to eq('https://bwt.cbp.gov/xml/bwt.xml')
  end

  it "QueryCore is able to get BWT XML " do
   #code
   queryCore  = Qcore.new
   bwtXML = queryCore.get_bwt_xml_data
   expect(bwtXML).not_to be nil
  end

  it "Core extract ports return an Array" do
    #New Query Core instance
    queryCore  = Qcore.new
    #Get XML data from BWT website
    bwtXML = queryCore.get_bwt_xml_data
    #set the ordereded ports into @ports
    ports = queryCore.extract_ports(bwtXML)
    expect(ports.class).to  eq(Array)
  end

end
