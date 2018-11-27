module Accessors
  def attr_accessor_with_history(*names)
    names.each do |name|
      set_name, get_name = ["#{name}=", name].map(&:to_sym)
      define_method(get_name) { instance_variable_get(:"@#{name}") }
      define_method(set_name) do |value|
        instance_variable_set(:"@#{name}", value)
        instance_variable_set(:"@#{name}_history", []) unless instance_variable_get(:"@#{name}_history")
        instance_variable_get(:"@#{name}_history").send(:<<, value)
      end
      define_method("#{name}_history") { instance_variable_get(:"@#{name}_history") }
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
