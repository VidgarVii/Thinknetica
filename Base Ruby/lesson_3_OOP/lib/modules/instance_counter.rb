module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end
  
  module ClassMethods
    attr_accessor :instances
  end

  module InstanceMethods
    private
    def register_instance(obj)
      obj.class.instances ||= 0
      obj.class.instances += 1
    end
  end
end
