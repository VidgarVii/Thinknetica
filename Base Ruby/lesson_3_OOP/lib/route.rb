class Route
  include InstanceCounter
  attr_reader :stations

  def initialize(first_state, last_state)    
    @stations = [first_state, last_state]
    validate!
    register_instance  
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

  def valid?
    validate!
    true
  rescue
    false
  end

  private

  def validate!
    @stations.each do |station|
      raise 'Маршрут должен состоять из станций' if station.class != Station
    end
    raise 'Тупиковые станции не должны совпадать' if @stations[0] === @stations[-1]
  end
  
  def valid_add_station(station, position)
    raise 'Маршрут должен состоять из станций' if station.class != Station
    raise 'Вы пытаетесь добавить станцию в конец или в начало пути' unless [-2, (1...@stations.size)].include?(position)
  end
end
