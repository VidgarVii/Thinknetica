class Vichislyator
  attr_accessor :day, :month, :year
  
  def initialize (day, month, year)
    self.day, self.month, self.year = day, month, year   
  end
  




end

n = Vichislyator.new(5, 10, 2015)
p n.day
p n.month
p n.year