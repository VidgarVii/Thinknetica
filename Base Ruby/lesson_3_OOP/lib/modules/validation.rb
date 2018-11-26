module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_reader :options

    def validate(name, option, arg = nil)
      @options ||= []
      @options << { name => { option => arg } }
    end
  end

  module InstanceMethods
    def valid?
      validate!
      true
    rescue StandardError
      false
    end

    protected

    def validate!
      self.class.options.each do |key|
        instance = key.keys[0].to_s
        arg = key.values[0].values[0]
        check_instatnce = instance_variable_get("@#{instance}")
        method = key.values[0].keys[0].to_sym
        send(method, check_instatnce, arg)
      end
    end

    def type(instance, class_name)
      puts instance
      raise 'Не совпадает класс' unless instance.class == class_name
    end

    def format(instance, format)
      raise 'Формат не корректен' if instance !~ format
    end

    def presence(instance, arg)
      raise 'Значение не должно быть пустым' if instance.to_s.empty? || instance.nil?
    end
  end
end
