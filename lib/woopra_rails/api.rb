module WoopraRails
  class << self
    def identify(name=nil, email=nil)
      @base_params += "&cv_name=#{name}&cv_email=#{email}"
      issue_request
    end

    def log_pageview(title, url)
      issue_request("&ce_name=pv&ce_title=#{URI::encode title}&ce_url=#{url}")
    end

    def log_event(event_name, args={})
      action = "&ce_name=#{URI::encode event_name}"
      args.each do |k,v|
        action += "&ce_#{k}=#{URI::encode v}"
      end
      issue_request(action)
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