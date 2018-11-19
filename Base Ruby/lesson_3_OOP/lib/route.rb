class Route
  include InstanceCounter
  attr_reader :stations

  def initialize(first_state, last_state)
    validate!(first_state, last_state)
    register_instance
    @stations = [first_state, last_state]    
  end

  def add_station(station, position = -2)
    valid_add_station(station, position)
    @stations.insert(position, station)
  end

  def rm_staion(station)
    @stations.delete(station)
  end

  def puts_stations
    @stations.each { |station| print "#{station.name} |" }
  end

  private

  def validate!(first_state, last_state)
    raise 'Маршрут должен состоять из станций' if (first_state.class != Station || last_state.class != Station)
    raise 'Маршрут должен состоять из разных станций' if first_state === last_state
  end
  
  def valid_add_station(station, position)
    raise 'Маршрут должен состоять из станций' if station.class != Station
    raise 'Вы пытаетесь добавить станцию в конец или в начало пути' unless [-2, (1...@stations.size)].include?(position)
  end
end
