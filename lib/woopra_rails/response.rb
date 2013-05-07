module WoopraRails
  class Response
    attr_accessor :success
    def new()
      success = false
    end

    def parse(json=nil)
      begin
        JSON.parse(json).each do |k,v|
          self.send("#{k}=".to_sym, v)
        end  
      rescue Exception => e
        WoopraError.get_error(e, json)
        send("success=", false)
      end
      self
    end

    def success?
      return true if self.send(:success) == 1 || WoopraRails.dryrun
      return false
    end
  end
end