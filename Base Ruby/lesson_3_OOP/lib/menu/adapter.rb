class Adapter
  attr_reader :routes, :stations, :trains

  def initialize
    @stations = []
    @trains = []
    @wagon = []
    @routes = []
  end
  
  def mk_station(name = "State #{rand(100)}")    
    @stations << Station.new(name)
  end

  def mk_train(type, number = "Train #{rand(100)}")
    @trains << CargoTrain.new(number) if type == 'cargo'
    @trains << PassengerTrain.new(number) if type == 'pass'
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
    @wagon << CargoWagon.new if type == 'cargo'
    @wagon << PassengerWagon.new if type == 'pass'    
  end
  
  def add_state_to_route(route = 0)
    puts 'Выберите порядковый номер станции'  
    @stations.each_with_index do |state, i| 
      puts "#{i} - #{state.name}" 
    end
    state = gets.chomp.to_i
    @routes[route].add_station(@stations[state])
  end

  def rm_state_from_route(route)
    return puts 'Вы не можете удалить станцию в маршруте из 2х станций' if @routes[route].stations.size == 2
    
    puts 'Выберите порядковый номер станции'
    @routes[route].stations.each_with_index do |state, i| 
      puts "#{i} - #{state.name}" 
    end
    state = gets.chomp.to_i
    @routes[route].rm_staion(@stations[state])
  end
  
  def assign_route_train(train)
    puts 'Выберите порядковый номер маршрута'
    @routes.each_with_index { |route, i| puts "#{i} - #{route}" }
    route = gets.chomp.to_i
    train.add_route(@routes[route])
  end
  
  def hook_wagon(train)
    return puts 'Создайте вагон' if @wagon.size.zero?

    puts 'Выберите порядковый номер вагона'
    @wagon.each_with_index do |wagon, i|
      puts "#{i} - #{wagon} : #{wagon.class}"
    end
    wagon = gets.chomp.to_i
    train.hook_wagon(@wagon[wagon])
  end

  def unhook_wagon(train)
    return puts 'Создайте вагон' if @wagon.size.zero?

    puts 'Выберите порядковый номер вагона'
    @wagon.each_with_index do |wagon, i|
      puts "#{i} - #{wagon} : #{wagon.class}"
    end
    wagon = gets.chomp.to_i
    train.unhook_wagon(@wagon[wagon])
  end

  def move(train)
    puts "Куда едим? \n  1 - Вперед\n  2 - Назад"
    dir = gets.chomp.to_i
    train.move_forward if dir == 1
    train.move_back if dir == 2
  end

  def puts_all
    puts 'Список поездов:'
    @trains.each { |item| puts "- #{item.number} : #{item.class}" }
    puts 'Список станций:'
    @stations.each do |item| 
      puts "- #{item.name} : Список ожидающих поездов: 
      Грузовые:" 
      item.list_train_by_type(CargoTrain)
      puts '  Пассажирские:' 
      item.list_train_by_type(PassengerTrain)
    end  
    puts 'Список маршрутов:'
    @routes.each_with_index do |route, index| 
      puts "#{index} - #{route}"
      route.puts_stations
     end     
    puts 'Список вагонов:'
    @wagon.each { |item| puts "- #{item} : #{item.class}" }
    p self
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
