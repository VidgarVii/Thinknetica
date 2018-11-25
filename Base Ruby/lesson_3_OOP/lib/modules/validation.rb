module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_reader :options

    def validate(name, option, arg = nil)
      @options ||= {}
      @options[name] = [option => arg]
    end
  end

  module InstanceMethods
    protected

    def validate!
      
    end

    def valid?
      validate!
      true
    rescue
      false
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

a = A.new('sss')
p a.instance_variables
p A.instance_variables
p a.class.options


