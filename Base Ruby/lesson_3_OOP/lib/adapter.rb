class Adapter
  attr_reader :routes, :stations

  def initialize
    @stations = []
    @trains = { pass: [], cargo: [] }
    @wagon = { pass: [], cargo: [] }
    @routes = []
  end
  
  def mk_station(name = "State #{rand(100)}")    
    @stations << Station.new(name)
  end

  def mk_train(type, number = "Train #{rand(100)}")
    @trains[:cargo] << CargoTrain.new(number) if type == 'cargo'
    @trains[:pass] << PassengerTrain.new(number) if type == 'pass'
  end
  
  def mk_route
    return puts 'Создайте как минимум 2 станции' if @stations.size < 2
    puts 'Список существующих станций:'
    @stations.each_with_index { |state, i| puts "#{i} - #{state}" }
    puts 'Введите номер начальной станции маршрута'
    st1 = gets.chomp.to_i
    puts 'Введите номер конечной станции маршрута'
    st2 = gets.chomp.to_i
    @routes << Route.new(@stations[st1], @stations[st2])
  end
  
  def mk_wagon(type)
    @wagon[:cargo] << CargoWagon.new if type == 'cargo'
    @wagon[:pass] << PassengerWagon.new if type == 'pass'    
  end
  
  def add_state_to_route(state, route = 0)
    @routes[route].add_station(@stations[state])
  end

  def rm_state_from_route(state, route = 0)
    @routes[route].rm_staion(@stations[state])
  end
  
  def assign_route(train, route = 0)
    train.add_route(route)
  end
  
  def hook_wagon(train, count = 1)    
  end

  def unhook_wagon(train, count = 1)    
  end

  def move(train, direction)
    train.move_forward if direction == 'forward'
    train.move_back if direction == 'backward'
  end

  def puts_all
    puts 'Список поездов:'
    puts '  Пассажирские:'
    @trains[:pass].each { |item| puts "- #{item.number}" }
    puts '  Грузовые:'
    @trains[:cargo].each { |item| puts "- #{item.number}" }   
    puts 'Список станций:'
    @stations.each { |item| puts "- #{item.name}"}    
    puts 'Список маршрутов:'
    puts @routes.each_with_index { |route, index| puts "#{index} - #{route.puts_stations}" }     
    puts 'Список вагонов:'
    puts '  Пассажирские:'
    puts @wagon[:pass]
    puts '  Грузовые:'
    puts @wagon[:cargo]
  end
  
  def create_all
    mk_wagon('cargo')
    mk_wagon('pass')
    mk_train('cargo', '0001')
    mk_train('pass', '0002')
    mk_station('State 0001')
    mk_station('State 0002')
    @routes << Route.new(@stations[0], @stations[1])
  end
end
