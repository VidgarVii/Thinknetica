module RailsWay
  attr_accessor :maker

  def valid?
    @maker.class == String
  end  
end
