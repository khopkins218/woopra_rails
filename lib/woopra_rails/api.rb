module WoopraRails
  class << self
    def identify(name=nil, email=nil)
      raise ArgumentError, "You must identify with a name" unless name
      raise ArgumentError, "You must identify with an email" unless email

      action = "&ce_name=identified&cv_name=#{URI::encode name}&cv_email=#{URI::encode email}"
      issue_request(action)
    end

    def log_pageview(title, url)
      issue_request("&ce_name=pv&ce_title=#{URI::encode title}&ce_url=#{url}")
    end

    def record(event_name, user_name="", user_email="", args={})
      name = begin
        URI::encode user_name
      rescue
        ""
      end

      email = begin
        URI::encode user_email
      rescue 
        ""
      end

      event_name = begin
        URI::encode event_name
      rescue 
        ""
      end
      action = "&cv_name=#{name}&cv_email=#{email}&ce_name=#{event_name}"

      args.each do |k,v|
        action += "&ce_#{k}=#{URI::encode v.to_s}"
      end
      ::Rails.logger.debug("Action: #{action}")
      issue_request(action)
    end

    def issue_request(action=nil)
      action = action.nil? ? base_params : base_params + action
      uri = URI.parse(action)
      resp = dryrun ? nil : Net::HTTP.get(uri)
      WoopraRails::Response.new.parse(resp)
    end
  end
end