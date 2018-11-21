class Train
  include RailsWay
  include InstanceCounter
  attr_reader :speed, :count_railwaycar, :number, :wagons, :type, :route
  @@trains = []
  REGEXP_NUMBER = /^\w{3}-?\w{2}$/

  def self.all
    @@trains
  end

  def self.find(number)
    @@trains.find { |train| train.number == number}    
  end

  def initialize(number, type)
    #passenger || cargo
    @number = number
    @type = type
    validate!
    @@trains << self
    register_instance    
    @speed = 0
    @route = nil
    @station_index = 0
    @wagons = []
  end

  def add_speed
    @speed += 10
  end

  def stop
    @speed = 0
  end

  def hook_wagon(wagon) 
    valid_wagon!(wagon)
    @wagons << wagon
    wagon.belongs_to = self
  end

  def unhook_wagon(wagon)
    @wagons.delete(wagon)
  end

  def each_wagons
    @wagons.each { |wagon| yield(wagon) }
  end
  
  def add_route(route)
    return if @route != nil

    valid_route(route)
    @route = route
    @route.stations[0].arrive(self)
  end

  def move_forward
    return unless next_station

    current_station.departure(self)
    @station_index += 1 
    current_station.arrive(self)
  end

  def move_backward
    return unless prev_station

    current_station.departure(self)
    @station_index -= 1
    current_station.arrive(self)
  end

  def next_station
    return if @route == nil

    @route.stations[@station_index + 1]
  end

  def current_station
    return  if @route == nil

    @route.stations[@station_index]
  end

  def prev_station
    return if @route == nil

    @route.stations[@station_index - 1] unless @station_index.zero?
  end

  def valid?
    validate!
    valid_maker!(@maker)
    true
  rescue
    false
  end  

  protected

  def validate!
    raise 'Не корректный номер' if @number !~ REGEXP_NUMBER
    raise 'Не соответствие типов' if (@type != 'cargo' && @type != 'passenger')
  end

  def valid_wagon!(wagon)
    raise 'Тип вагона не совпадает с типом поезда' if wagon.type != self.type
  end

  def valid_route(route)
    raise 'Это не маршрут!' if route.class != Route
  end
end
