require 'spec_helper'

describe WoopraRails do
  context "post init" do
    it "should define module instance vars" do
      [:@endpoint, :@dryrun, :@config, :@env, :@base_params].each do |v|
        WoopraRails.instance_variables.include?(v).should be_true
      end
    end  
  end
end