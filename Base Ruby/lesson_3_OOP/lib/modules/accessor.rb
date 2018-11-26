module Accessors
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMeyhods
  end

  module ClassMethods
    def attr_accessor_with_history(*names)
      names.each do |name|
        var_name, set_name, get_name = ["@#{name}", "#{name}=", name].map(&:to_sym)
        define_method(get_name) { instance_variable_get(var_name)[-1] }
        define_method(set_name) do |value|
          eval("#{var_name} ||= []")
          eval("#{var_name} << value")
        end
      end
    end

    def strong_attr_accessor(name, class_name)
      var_name, set_name, get_name = ["@#{name}", "#{name}=", name].map(&:to_sym)
      define_method(get_name) { instance_variable_get(var_name) }
      define_method(set_name) do |value|
        raise 'Не совпадает класс' unless value.class == class_name

        instance_variable_set(var_name, value)
      end
    end
  end

  module InstanceMeyhods
    def method_missing(name_instance)
      return unless name_instance.to_s.include?('_history')

      instance = name_instance.to_s.split('_')[0]
      instance_variable_get("@#{instance}".to_sym)
      super
    end
  end
end
