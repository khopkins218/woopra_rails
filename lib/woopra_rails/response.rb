module WoopraRails::Response
  class << self
    attr_accessor :success
    def new(json=nil)
      if json
        JSON.parse(json).each do |k,v|
          self.send("#{k}=".to_sym, v)
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