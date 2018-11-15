module InstanceCounter
  #def self.included(base)
  #  base.extend ClassMethods
  #  base.send :include, InstanceMethods
  #end
end

module ClassMethods
  #attr_accessor :instances
  
  def instances
    @@instances
  end
end

module InstanceMethods
  private  
  def register_instance
    #obj.class.instances ||= 0
    #obj.class.instances += 1  
    @@instances ||= 0    
    @@instances += 1
  end
end