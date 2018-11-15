module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end
  module ClassMethods
    attr_reader :instances
    
    def increment_instances
      @instances ||= 0
      @instances += 1
    end
  end

  module InstanceMethods
    private  
    def register_instance
      self.class.increment_instances 

    end
  end
end
