class Wagon
  attr_accessor :belongs_to
  attr_reader :type
  
  def initialize(type)
    #passenger || cargo
    @type = type
    @belongs_to = nil
  end
end
