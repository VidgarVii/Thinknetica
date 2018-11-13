class RailRoad
  def initialize
    @stations = []
    @trains = []
    @wagons = []
    @routes = []
    puts WELOCOME
  end

  def start
    loop do
      system('clear')
      puts MENU[:main]
      puts '0 - Выйти из программы.'
      choice = gets.chomp.to_i
      exit?(choice)
      next_menu(choice)
    end
  end

  private
  
  def exit?(choice)
    abort if choice.zero?
    start if choice == 9
  end
  
  def next_menu(choice)
    case choice
    when 1 then create_menu
    when 2 then route_menu
    when 3 then train_menu 
    when 4 then puts_all
    end
  end

  def puts_all
    system('clear')
    puts 'Список поездов:'
    @trains.each { |train| show_train(train) }
    puts "\nСписок станций:"
    @stations.each do |item| 
      puts "- #{item.name} : Список ожидающих поездов: 
      Грузовые:" 
      item.list_train_by_type('cargo')
      puts '  Пассажирские:' 
      item.list_train_by_type('passenger')
    end  
    puts 'Список маршрутов:'
    @routes.each_with_index do |route, index| 
      puts "#{index} - "
      route.puts_stations
     end     
    puts "\nСписок вагонов:"
    @wagons.each { |item| puts "- #{item} : #{item.belongs_to}" }
    puts 'Нажмите Enter'
    wait = gets
  end

  def create_menu
    system('clear')
    puts MENU[:create]
    choice = gets.chomp.to_i
    exit?(choice)
    case choice
    when 1 then create_station
    when 2 then create_train
    when 3 then create_route 
    when 4 then create_wagon
    when 5 then create_all 
    end
  end

  def route_menu
    system('clear')
    if @routes.size.zero?
      puts 'Создайте маршрут'
      enter = gets
      start
    end
    
    puts MENU[:route]
    choice = gets.chomp.to_i
    exit?(choice)
    @routes.each_with_index do |route, i|
      print "#{i} - "; route.puts_stations
    end
    puts "\nВыберите маршрут"
    route = gets.chomp.to_i
    case choice
    when 1 then add_station_route(@routes[route])
    when 2 then rm_station_route(@routes[route])
    end
  end

  def add_station_route(route)
    @stations.each_with_index do |station, i|
      puts "#{i} - #{station.name}"
    end
    puts 'Выберите станцию'
    station = gets.chomp.to_i
    route.add_station(@stations[station])
  end

  def rm_station_route(route)
    route.stations.each_with_index do |station, i|
      puts "#{i} - #{station.name}"
    end
    puts 'Выберите станцию'
    station = gets.chomp.to_i
    route.rm_staion(route.stations[station])
  end

  def train_menu
    system('clear')
    if @trains.size.zero?
      puts 'Создайте поезд'
      enter = gets
      start
    end

    puts MENU[:train]
    choice = gets.chomp.to_i
    exit?(choice)
    @trains.each_with_index do |train, i|
      puts "#{i} - #{train.number}:#{train.type}"
    end
    puts 'Выберите поезд'
    train = gets.chomp.to_i
    case choice
    when 1 then assign_route_train(@trains[train])
    when 2 then hook_wagon(@trains[train])
    when 3 then unhook_wagon(@trains[train])
    when 4 then move(@trains[train]) 
    end
  end

  def assign_route_train(train)
    puts 'Выберите порядковый номер маршрута'
    @routes.each_with_index { |route, i| puts "#{i} - #{route}" }
    route = gets.chomp.to_i
    train.add_route(@routes[route])
  end

  def move(train)
    puts "Куда едим? \n  1 - Вперед\n  2 - Назад"
    dir = gets.chomp.to_i
    train.move_forward if dir == 1
    train.move_back if dir == 2
  end

  def hook_wagon(train)
    return puts 'Создайте вагон' if @wagons.size.zero?

    puts 'Выберите порядковый номер вагона'
    @wagons.each_with_index do |wagon, i|
      if wagon.belongs_to.nil?
        puts "#{i} - #{wagon} : #{wagon.type}" 
      end
    end
    wagon = gets.chomp.to_i
    train.hook_wagon(@wagons[wagon])
  end

  def unhook_wagon(train)
    return puts 'Создайте вагон' if @wagons.size.zero?

    puts 'Выберите порядковый номер вагона'
    train.wagons.each_with_index do |wagon, i|
      puts "#{i} - #{wagon} : #{wagon.type}"
    end
    wagon = gets.chomp.to_i
    train.unhook_wagon(train.wagons[wagon])
  end

  def create_station
    puts 'Название станции'
    name = gets.chomp
    @stations << Station.new(name)
  end

  def create_train
    puts MENU[:type]
    type = gets.chomp.to_i
    puts 'Выберите номер или название поезда'
    name = gets.chomp
    @trains << Train.new(name, 'passenger') if type == 1
    @trains << Train.new(name, 'cargo') if type == 2
  end

  def create_route
    if @stations.size < 2
      puts 'Создайте 2 станции'
      wait = gets
      start
    end

    @stations.each_with_index { |station, i| puts "#{i} - #{station.name}" }
    puts 'Выберите начальную станцию'
    start = gets.chomp.to_i
    puts 'Выберите конечную станцию'
    finish = gets.chomp.to_i
    @routes << Route.new(@stations[start], @stations[finish])
  end

  def create_wagon
    puts MENU[:type]
    type = gets.chomp.to_i
    @wagons << Wagon.new('passenger') if type == 1
    @wagons << Wagon.new('cargo') if type == 2
  end

  def create_all
    @wagons << Wagon.new('passenger')
    @wagons << Wagon.new('carge')
    @trains << Train.new('Train 0001', 'passenger')
    @trains << Train.new('Train 0002', 'carge')
    @stations << Station.new('Трансильвания')
    @stations << Station.new('Пенсильвания')
    @routes << Route.new(@stations[0], @stations[1])
  end

  def show_train(train)  
    puts "\n#{train.type}: #{train.number}"
    count = train.wagons.size
    puts "Кол-во вагонов: #{count}" 
    puts WAGONS[count]   
  end
end
