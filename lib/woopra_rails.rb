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
  @config = {}

  class << self
    def config=(config)
      @config = config
    end

    def config
      @config
    end

    def dryrun
      @config["dryrun"]
    end

    def account
      @config["account"]
    end

    def env
      return ::Rails.env if defined? Rails
      ""
    end

    def endpoint
      'http://www.woopra.com/track/ce/'
    end

    def base_params
      "#{endpoint}?host=#{account}&response=json&timeout=300000"
    end
  end
end
