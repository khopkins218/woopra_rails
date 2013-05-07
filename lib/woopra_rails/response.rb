module WoopraRails::Response
  class << self
    attr_accessor :success
    def new(json=nil)
      if json
        begin
          JSON.parse(json).each do |k,v|
            self.send("#{k}=".to_sym, v)
          end  
        rescue Exception => e
          self.send("success=", 1)
        end
        
      end
      self
    end

    def success?
      return true if self.send(:success) == 1 || WoopraRails.dryrun
      return false
    end
  end
end