class Wagon
  include Manufactur
  include InstanceCounter
  attr_accessor :belongs_to
  attr_reader :type, :number
  
  def initialize(type)
    #passenger || cargo
    @type = type
    validate!
    @belongs_to = nil    
    register_instance
    @number = self.class.instances
  end

  def valid?
    validate!
    valid_maker!(@maker)
    true
  rescue
    false
  end

  protected

  def validate!
    raise 'Не соответствие типов' if (@type != 'cargo' && @type != 'passenger')
  end  
end
