class Route
  include InstanceCounter
  attr_reader :stations

  def initialize(first_state, last_state)
    register_instance
    @stations = [first_state, last_state]
    validate!
  end

  def add_station(station, position = -2)
    valid_position(position)
    @stations.insert(position, station)
  end

  def rm_staion(station)
    @stations.delete(station)
  end

  def puts_stations
    @stations.each { |station| print "#{station.name} |" }
  end

  private

  def validate!
    @stations.each do |station|
      raise 'Маршрут должен состоять из станций' if station.class != Station
    end
  end
  
  def valid_position(position)
    raise 'Вы пытаетесь добавить станцию в конец или в начало пути' unless [-2, (1...@stations.size)].include?(position)
  end
end
