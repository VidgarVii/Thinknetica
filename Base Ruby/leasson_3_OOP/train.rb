=begin 
+ Имеет номер (произвольная строка) и 
+       тип (грузовой, пассажирский) и 
+       количество вагонов, эти данные указываются при создании экземпляра класса      
+ Может набирать скорость
+ Может возвращать текущую скорость
+ Может тормозить (сбрасывать скорость до нуля)
+ Может возвращать количество вагонов
+ Может прицеплять/отцеплять вагоны (по одному вагону за операцию, метод просто увеличивает или уменьшает количество вагонов). Прицепка/отцепка вагонов может осуществляться только если поезд не движется.
+ Может принимать маршрут следования (объект класса Route). 
+ При назначении маршрута поезду, поезд автоматически помещается на первую станцию в маршруте.
Может перемещаться между станциями, указанными в маршруте. Перемещение возможно вперед и назад, но только на 1 станцию за раз.
Возвращать предыдущую станцию, текущую, следующую, на основе маршрута 
=end
require_relative 'route'

class Train
  attr_reader :speed, :count_railwaycar, :current_station

  def initialize(number, type, count_railwaycar)
    return unless %w(freight passenger).include?(type)
    @numbe = number
    @type = type
    @count_railwaycar =  count_railwaycar.to_i
    @speed = 0
    @route = nil
    @current_station = nil
  end

  def add_speed
    @speed += 10
  end

  def stop
    @speed = 0
  end

  def add_or_rm_railwaycar(action)
    @count_railwaycar = ( action == 'add' ) ? @count_railwaycar.next : @count_railwaycar.pred
  end  

  def add_route(route)
    @route = route
    @current_station = @route.stations[0]
  end
  
end
