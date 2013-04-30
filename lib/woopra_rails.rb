require "woopra_rails/version"
require "woopra_rails/engine"
require 'uri'
require 'socket'
require 'net/http'
require 'fileutils'

class WoopraError < StandardError; end

module WoopraRails::Response
  class << self
    attr_accessor :success
    def new(json)
      JSON.parse(json).each do |k,v|
        self.send("#{k}=".to_sym, v)
      end
      self
    end

    def success?
      return true if self.send(:success) == 1
      return false
    end
  end
end

module WoopraRails::Session
  extend ActiveSupport::Concern
  included do
    before_filter :set_or_use_woopra_cookie

    def set_or_use_woopra_cookie
      session[:woopra_user_id] = SecureRandom.hex(16) unless !session || session[:woopra_user_id]
    end
  end

  class << self
    def user_id
      begin
        session[:woopra_user_id]
      rescue
        ""
      end
    end

    def page_path
      request.url
    end
  end
end

module WoopraRails
  @account      = nil
  @host         = 'http://www.woopra.com'
  @endpoint     = '/track/ce/'
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
      get_env_config
      begin
        puts("Woopra Initialized")
      rescue Exception => e
        puts("Error on init: #{e.message}")
      end
    end

    def set_base
      @base_params = "#{@host}#{@endpoint}?host=#{@account}&response=json&cookie=#{WoopraRails::Session.user_id}&timeout=300000"
      puts "Base is set"
    end

    def identify(email)
      @base_params += "&cv_name=#{email}"
      issue_request
    end

    def log_pageview(title, url)
      issue_request("&ce_title=#{URI::encode title}&ce_url#{url}")
    end

    def issue_request(action=nil)
      action = action.nil? ? @base_params : @base_params + action
      uri = URI.parse(action)
      resp = WoopraRails::Response.new(Net::HTTP.get(uri))
      return resp if resp.success?
      raise WoopraError
    end
  end
end
