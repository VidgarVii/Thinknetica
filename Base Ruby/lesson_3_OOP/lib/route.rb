class Route
  attr_reader :stations

  def initialize(first_state, last_state)
    @stations = [first_state, last_state]
  end

  def add_station(station, position = -2)
    check = [-2, (1...stations.size)].include?(position)
    @stations.insert(position, station) if check
    puts 'Вы пытаетесь добавить станцию в конец или в начало пути' unless check
  end

  def rm_staion(station)
    return puts 'У маршрута не может быть меньше 2х станций' if @stations.size == 2

    @stations.delete(station)
  end

  def puts_stations
    @stations.each { |station| print "#{station.name} |" }
  end
end
