class Wagon
  include RailsWay
  attr_accessor :belongs_to
  attr_reader :type
  
  def initialize(type)
    #passenger || cargo
    @type = type
    validate!
    @belongs_to = nil    
  end

  def valid?
    @maker.class == String
  end

  protected

  def validate!
    raise 'Не соответствие типов' if (@type != 'cargo' && @type != 'passenger')
  end  
end
