=begin
+ Имеет начальную и конечную станцию, а также список промежуточных станций. Начальная и конечная станции указываютсся при создании маршрута, а промежуточные могут добавляться между ними. a.insert(2, 99)
+ Может добавлять промежуточную станцию в список
+ Может удалять промежуточную станцию из списка
+ Может выводить список всех станций по-порядку от начальной до конечной 
=end

class Route
  attr_reader :stations
  
  def initialize(first_state, last_state)
    @stations = [first_state, last_state]
  end

  def add_station(station, position = -2)
    check = (1...stations.size).include?(position)
    @stations.insert(position, station) if check
    puts 'Вы пытаетесь добавить станцию в конец или в начало пути' unless check
  end

  def rm_staion(station)
    @stations.delete(station)
  end
  
  def puts_stations
    @stations.each{ |station| puts station.name}
  end  
end
