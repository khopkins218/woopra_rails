require 'uri'
require 'socket'
require 'net/http'
require 'fileutils'

[
  'version',
  'engine',
  'error',
  'response',
  'api'
].each{ |f| require "woopra_rails/#{f}" }

module WoopraRails
  @endpoint     = 'http://www.woopra.com/track/ce/'
  @dryrun       = false
  @config       = {}
  @env          = "development"
  @base_params  = ""

  class << self
    def config=(config)
      @config = config
    end

    def init
      begin
        @env = ::Rails.env if defined? Rails
        @base_params = "#{@endpoint}?host=#{account}&response=json&timeout=300000"
      rescue Exception => e
        puts("Error on init: #{e.message}")
      end
    end

    def dryrun
      return @config["dryrun"] == true
    end

    def account
      @config["account"]
    end
  end
end
