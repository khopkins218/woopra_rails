class ApplicationController < ActionController::Base
  protect_from_forgery

  def index
    
  end

  def create
    logger.debug("Params: #{params.inspect}")
  end
end
