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