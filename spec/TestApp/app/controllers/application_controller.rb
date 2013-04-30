class ApplicationController < ActionController::Base
  protect_from_forgery
  include WoopraRails::Session

  def index
    
  end

  def create
    logger.debug("Params: #{params.inspect}")
  end
end
