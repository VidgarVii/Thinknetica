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
        check_instatnce =  instance_variable_get("@#{instance}")
        type!(check_instatnce, arg) if key.values[0][:type]
        presence!(check_instatnce) if key.values[0].keys.include?(:presence)
        format!(check_instatnce, arg) if key.values[0][:format]
      end
    end

    def type!(instance, class_name)
      puts instance
      raise 'Не совпадает класс' unless instance.class == class_name
    end

    def format!(instance, format)
      raise 'Формат не корректен' if instance !~ format
    end

    def presence!(instance)
      raise 'Значение не должно быть пустым' unless instance
    end
  end
end
