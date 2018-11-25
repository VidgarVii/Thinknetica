module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_reader :options

    def validate(name, option, arg = nil)
      @options ||= []
      @options << {name => {option => arg}}
    end
  end

  module InstanceMethods
    protected

    def validate!
      self.class.options.each do |key|
        instance = key.keys[0].to_s
        puts key.values[0].values if key.values[0][:type]
        puts key.values[0].values if key.values[0][:presence]
        eval("presence!(@#{instance})") if key.values[0][:format]
      end
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
