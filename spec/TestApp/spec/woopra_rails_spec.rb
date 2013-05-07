require 'spec_helper'

describe WoopraRails do
  it "should define module instance var for @config" do
    WoopraRails.instance_variables.include?(:@config).should be_true
  end

  it "should have a valid environment" do
    WoopraRails.env.should == Rails.env
  end

  it "should have an endpoint" do
    WoopraRails.endpoint.should == "http://www.woopra.com/track/ce/"
  end

  it "should have dryrun set to the value in the config file" do
    WoopraRails.dryrun.should == CONFIG_YML[::Rails.env.to_s]["dryrun"]
  end

  it "should have account set to the value in the config file" do
    WoopraRails.account.should == CONFIG_YML[::Rails.env.to_s]["account"]
  end

  it "should respond with a valid URI for base params" do
    WoopraRails.base_params.should == URI.encode(WoopraRails.base_params)
  end

  it "should include always necesary params in base params" do
    ["host","response","timeout"].each do |p|
      WoopraRails.base_params.include?(p).should be_true
    end
  end
end