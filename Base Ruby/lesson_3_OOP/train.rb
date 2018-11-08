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
+ Может перемещаться между станциями, указанными в маршруте. + Перемещение возможно вперед и назад, но только на 1 станцию за раз.
+ Возвращать предыдущую станцию, текущую, следующую, на основе маршрута 
=end
class Train
  attr_reader :speed, :count_railwaycar, :type, :number

  def initialize(number, type, count_railwaycar)
    return unless %w(freight passenger).include?(type)
    @number = number
    @type = type
    @count_railwaycar =  count_railwaycar.to_i
    @speed = 0
    @route = nil
    @station_index = 0
  end

  def add_speed
    @speed += 10
  end

  def stop
    @speed = 0
  end

  def add_railwaycar
    @count_railwaycar += 1 if @speed == 0
  end  

  def rm_railwaycar
    @count_railwaycar -= 1 if @speed == 0
  end

  def add_route(route)
    @route = route
    @route.stations[0].arrive(self)
  end  

  def move_forward
    return unless next_station
    current_station.departure(self)
    @station_index += 1 
    current_station.arrive(self)
  end

  def back_forward
    return unless prev_station
    current_station.departure(self)
    @station_index -= 1 
    current_station.arrive(self)
  end
  
  def next_station   
    @route.stations[@station_index + 1] unless @station_index == -1
  end
  
  def current_station
    @route.stations[@station_index]
  end

  def prev_station   
    @route.stations[@station_index - 1] unless @station_index == 0
  end
end
