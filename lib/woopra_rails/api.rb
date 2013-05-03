module WoopraRails
  class << self
    def identify(name="", email="", session="")
      @session = Digest::MD5.hexdigest(session.nil? ? email : session)
      set_base
      enc_name = begin
        URI::encode name
      rescue
        ""
      end

      enc_email = begin
        URI::encode email
      rescue 
        ""
      end
      
      @base_params += "&cv_name=#{enc_name}&cv_email=#{enc_email}"
      issue_request
    end

    def log_pageview(title, url)
      issue_request("&ce_name=pv&ce_title=#{URI::encode title}&ce_url=#{url}")
    end

    def log_event(event_name, args={})
      action = "&ce_name=#{URI::encode event_name.to_s}"
      args.each do |k,v|
        action += "&ce_#{k}=#{URI::encode v.to_s}"
      end
      issue_request(action)
    end

    def issue_request(action=nil)
      action = action.nil? ? @base_params : @base_params + action
      uri = URI.parse(action)
      resp = WoopraRails::Response.new(dryrun ? nil : Net::HTTP.get(uri))
      return resp if resp.success?
      raise WoopraError
    end
  end
end