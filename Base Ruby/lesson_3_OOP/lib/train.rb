class Train
  include RailsWay
  include InstanceCounter
  attr_reader :speed, :count_railwaycar, :number, :wagons, :type
  @@trains = []

  def self.all
    @@trains
  end

  def self.find(number)
    @@trains.find { |train| train.number == number}    
  end

  def initialize(number, type)
    #passenger || cargo
    @@trains << self
    register_instance
    @number = number
    @type = type
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
    if wagon.type == self.type
      wagon.belongs_to = self
      @wagons << wagon
    else
      puts 'Типы не совпадают'
    end
  end

  def unhook_wagon(wagon)
    @wagons.delete(wagon)
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

  def move_backward
    return unless prev_station

    current_station.departure(self)
    @station_index -= 1
    current_station.arrive(self)
  end

  def next_station
    return puts 'Нет маршрута' if @route == nil

    @route.stations[@station_index + 1]
  end

  def current_station
    return puts 'Нет маршрута' if @route == nil

    @route.stations[@station_index]
  end

  def prev_station
    return puts 'Нет маршрута' if @route == nil

    @route.stations[@station_index - 1] unless @station_index.zero?
  end
end
