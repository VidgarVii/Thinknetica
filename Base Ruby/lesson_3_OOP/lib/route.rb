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
    @stations.delete(station)
  end

  def puts_stations
    @stations.each { |station| print "#{station.name} |" }
  end
end
