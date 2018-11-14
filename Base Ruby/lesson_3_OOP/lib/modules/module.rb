module RailsWay
  def self.included(base)
    base.send :include, InstanceMethods
  end

  module InstanceMethods
    attr_accessor :maker
  end
end
