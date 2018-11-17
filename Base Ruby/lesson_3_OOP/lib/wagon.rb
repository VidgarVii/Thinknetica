class Wagon
  include RailsWay
  attr_accessor :belongs_to
  attr_reader :type
  
  def initialize(type)
    #passenger || cargo
    @type = type
    @belongs_to = nil
    validation!
  end

  protected

  def validation!
    raise 'Не соответствие типов' if (@type != 'cargo' && @type != 'passenger')
  end  
end
