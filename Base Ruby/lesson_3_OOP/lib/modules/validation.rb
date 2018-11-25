module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def validate(name, opts, *arg)
      var = "@#{name}".to_sym
      p instance_methods
    end
  end

  module InstanceMethods
    protected

    def valid?
      validate!
      true
    rescue
      false
    end
    
    
    def validate!
      
    end

    def type!(instance, class_name)
      raise 'Не совпадает класс' unless instance.class == class_name
    end
    

    def format!(instance, format)
      raise 'Формат не корректен' if instance !~ format
    end
    
    def presence!(instance)
      raise 'Значение не должно быть пустым' if instance.empty? || instance.nil?
    end
  end
end

class A
  include Validation

  validate :name, :presence
  validate :name, :format, /A-Z/
  validate :name, :type, String

  def initialize(name)    
    @name = name
    validate!
  end  
end

a = A.new('')
p a.instance_variables
puts a.instance_variable_get(:@name)

