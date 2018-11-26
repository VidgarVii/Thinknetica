class Route
  include Validation
  include InstanceCounter
  attr_reader :stations
  validate :last_state, :type, Station
  validate :first_state, :type, Station

  def initialize(first_state, last_state)
    @first_state = first_state
    @last_state = last_state
    @stations = [first_state, last_state]
    validate!
    check_stations!
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

  private

  def check_stations!
    raise 'Тупиковые станции не должны совпадать' if @stations[0] === @stations[-1]
  end

  def valid_add_station(station, position)
    raise 'Маршрут должен состоять из станций' if station.class != Station
    raise 'Вы пытаетесь добавить станцию в конец или в начало пути' unless [-2, (1...@stations.size)].include?(position)
  end
end
