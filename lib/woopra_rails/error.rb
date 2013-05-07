class WoopraError < StandardError
  class << self
    def json_exception?(e)
      e.class == JSON::ParserError
    end

    def account_exception?(json)
      ["host", "not registered!"].all?{|w| json.downcase.include? w }
    end

    def get_error(e, json)
      if json_exception?(e) && account_exception?(json)
        raise WoopraError, "Your account is incorrect.  Woopra responded that '#{WoopraRails.account}'' was not registered."
      elsif json_exception?(e)
        ::Rails.logger.debug("JSON::ParserError in WoopraRails.  Not raising, but you should check.")
      end
    end
  end
end
