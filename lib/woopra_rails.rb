require "woopra_rails/version"
require "woopra_rails/engine"
require 'uri'
require 'socket'
require 'net/http'
require 'fileutils'

[
  'version',
  'engine',
  'error',
  'response',
  'session',
  'api'
].each{ |f| require "woopra_rails/#{f}" }

module WoopraRails
  @endpoint     = 'http://www.woopra.com/track/ce/'
  @dryrun       = false
  @config       = {}
  @env          = "development"

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
      @account = @config["account"]
      @base_params = "#{@host}#{@endpoint}?host=#{account}&response=json&cookie=#{WoopraRails::Session.user_id}&timeout=300000"
    end

    def account
      @config["account"]
    end
  end
end
