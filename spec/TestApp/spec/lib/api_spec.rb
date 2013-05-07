require 'spec_helper'

describe WoopraRails do
  context "expected current api methods" do
    it "should have respond to 'identify'" do
      WoopraRails.respond_to?(:identify).should be_true
    end

    it "should respond to 'log_pageview'" do
      WoopraRails.respond_to?(:log_pageview).should be_true
    end

    it "should respond to 'record'" do
      WoopraRails.respond_to?(:record).should be_true
    end
  end

  context "#identify" do
    it "should raise an argument error when nothing is passed" do
      expect {
        WoopraRails.identify
      }.to raise_error(ArgumentError)
    end

    it "should raise an argument error with a message when not passing a name" do
      expect {
        WoopraRails.identify
      }.to raise_error(ArgumentError, "You must identify with a name")
    end

    it "should raise an argument error with a message when not passing an email" do
      expect {
        WoopraRails.identify("woopra user")
      }.to raise_error(ArgumentError, "You must identify with an email")
    end

    it "should return a WoopraRails::Response object" do
      vcr "success" do
        WoopraRails.identify("woopra user", "me@wooprauser.com").class.should == WoopraRails::Response
      end
    end

    it "should return a successful response with valid arguments" do
      vcr "success-good-arguments" do
        WoopraRails.identify("woopra user", "me@wooprauser.com").success?.should be_true
      end
    end

    it "should return a successful response and not check validity of email" do
      vcr "success-bad-email" do
        WoopraRails.identify("woopra user", "me@wooprauser").success?.should be_true
      end
    end
  end
end