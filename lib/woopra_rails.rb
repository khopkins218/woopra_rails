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
  @session      = ""

  class << self
    def config=(config)
      @config = config
    end

    def get_env_config
      @env = ::Rails.env if defined? Rails
      set_base
    end

    def init
      begin
        get_env_config
      rescue Exception => e
        puts("Error on init: #{e.message}")
      end
    end

    def set_base
      @base_params = "#{@endpoint}?host=#{account}&response=json&cookie=#{@session}&timeout=300000"
    end

    def account
      @config["account"]
    end
  end
end
