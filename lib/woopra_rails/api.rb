module WoopraRails
  class << self
    def identify(name="", email="")
      session = "woopra_rails-#{Digest::MD5.hexdigest("#{name} #{email}")}" rescue ""
      ::Rails.logger.debug "Session: #{session}"
      name = begin
        URI::encode name
      rescue
        ""
      end

      email = begin
        URI::encode email
      rescue 
        ""
      end
      
      action = "&cookie=#{session}&cv_name=#{name}&cv_email=#{email}"
      ::Rails.logger.debug("User info: #{name.inspect}, #{email.inspect}")
      issue_request(action)
    end

    def log_pageview(title, url)
      issue_request("&ce_name=pv&ce_title=#{URI::encode title}&ce_url=#{url}")
    end

    def record(event_name, user_name="", user_email="", args={})
      session = "woopra_rails-#{Digest::MD5.hexdigest("#{user_email} #{user_name}")}" rescue ""
      ::Rails.logger.debug "Session: #{session}"
      name = begin
        URI::encode name
      rescue
        ""
      end

      email = begin
        URI::encode email
      rescue 
        ""
      end

      event_name = begin
        URI::encode event_name
      rescue 
        ""
      end
      action = "&cookie=#{session}&cv_name=#{user_name}&cv_email=#{user_email}&ce_name=#{event_name}"

      args.each do |k,v|
        action += "&ce_#{k}=#{URI::encode v.to_s}"
      end
      ::Rails.logger.debug("Action: #{action}")
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