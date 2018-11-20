class RailRoad

  # R - При создании вагона указывать кол-во мест или общий объем, в зависимости от типа вагона
  # Выводить список вагонов у поезда (в указанном выше формате), используя созданные методы
  # Выводить список поездов на станции (в указанном выше формате), используя  созданные методы
  # Занимать место или объем в вагоне

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
      choice = gets.chomp
      break if choice == '0'
      next_menu(choice)
    end
  end

  private
  
  def next_menu(choice)
    case choice
    when '1' then create_menu
    when '2' then route_menu
    when '3' then train_menu 
    when '4' then puts_all
    end
  end

  def puts_all
    system('clear')
    puts 'Список поездов:'
    @trains.each { |train| show_train(train) }
    puts "\nСписок станций:"

    # Переписать кастыль с использованием метода с блоком.
    # Формат - Номер поезда, тип, кол-во вагонов
    # Для каждого поезда на станции выводить список вагонов в формате - 
    # Номер вагона (можно назначать автоматически), тип вагона, 
    # кол-во свободных и занятых мест (для пассажирского вагона) или 
    # кол-во свободного и занятого объема (для грузовых вагонов).

    @stations.each do |item| 
      puts "- #{item.name} : Список ожидающих поездов: 
      Грузовые:" 
      item.list_train_by_type('cargo')
      puts '  Пассажирские:'
      item.list_train_by_type('passenger')
    end  


    puts 'Список маршрутов:'
    @routes.each_with_index do |route, index| 
      print "\n#{index} - "
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
    choice = gets.chomp
    case choice
    when '1' then create_station
    when '2' then create_train
    when '3' then create_route 
    when '4' then create_wagon
    when '5' then create_all
    end
  end

  def route_menu
    system('clear')
    return error 'Создайте маршрут' if @routes.size.zero?
    
    puts MENU[:route]
    choice = gets.chomp    
    @routes.each_with_index do |route, i|
      print "#{i} - "; route.puts_stations
    end

    puts "\nВыберите маршрут"
    route = gets.chomp.to_i
    return error 'Маршрут не выбран' unless (@routes[route] || !route.zero?)
    
    case choice
    when '1' then add_station_route(@routes[route])
    when '2' then rm_station_route(@routes[route])
    end
  end

  def add_station_route(route)
    stations = Station.all - route.stations
    return error 'Создайте станцию' if stations.size.zero?   
  
    begin
      stations.each_with_index do |station, i|
        puts "#{i} - #{station.name}"
      end
      puts 'Выберите станцию'
      station = gets.chomp.to_i
      route.add_station(stations[station])
    rescue => exception
      puts exception
      retry
    end
    
  end

  def rm_station_route(route)
    return error 'У маршрута не может быть меньше 2х станций' if route.stations.size == 2
    
    route.stations.each_with_index do |station, i|
      puts "\n#{i} - #{station.name}"
    end
    puts 'Выберите станцию'
    station = gets.chomp.to_i
    route.rm_staion(route.stations[station])
  end

  def train_menu
    system('clear')
    return error 'Создайте поезд' if @trains.size.zero?

    puts MENU[:train]
    choice = gets.chomp
    @trains.each_with_index do |train, i|
      puts "#{i} - #{train.number}:#{train.type}"
    end
    puts 'Выберите поезд'
    train = gets.chomp.to_i
    case choice
    when '1' then assign_route_train(@trains[train])
    when '2' then hook_wagon(@trains[train])
    when '3' then unhook_wagon(@trains[train])
    when '4' then move(@trains[train]) 
    end
  end

  def assign_route_train(train)
    return error 'Создайте маршрут' if @routes.size.zero?
   begin
    puts 'Выберите порядковый номер маршрута'
    @routes.each_with_index { |route, i| puts "#{i} - #{route}" }
    route = gets.chomp.to_i
    train.add_route(@routes[route])
   rescue => exception
     puts exception
     retry
   end
    
  end

  def move(train)
    return error 'У поезда нет маршрута' if train.route.nil?
    
    puts "Куда едим? \n  1 - Вперед\n  2 - Назад"
    dir = gets.chomp.to_i
    train.move_forward if dir == 1
    train.move_back if dir == 2
  end

  def hook_wagon(train)
    return error 'Создайте вагон' if @wagons.size.zero?
    
    wagons = @wagons.select do |wagon| 
      wagon.type == train.type && wagon.belongs_to.nil?
    end

    begin
      wagons.each_with_index do |wagon, i|     
        puts "#{i} - #{wagon} : #{wagon.type}"
      end
      puts 'Выберите порядковый номер вагона'
      wagon = gets.chomp.to_i
      train.hook_wagon(wagons[wagon])
    rescue => exception
      puts exception
      retry
    end    
  end

  def unhook_wagon(train)
    return error 'Не чего отцеплять' if train.wagons.size.zero?

    puts 'Выберите порядковый номер вагона'
    train.wagons.each_with_index do |wagon, i|
      puts "#{i} - #{wagon} : #{wagon.type}"
    end
    wagon = gets.chomp.to_i
    return error 'Выбор некорректен' unless train.wagons[wagon]
    
    train.unhook_wagon(train.wagons[wagon])
  end

  def create_station
    begin
      puts 'Введите название станции'
      name = gets.chomp
      @stations << Station.new(name)
    rescue => exception
    puts exception
    retry
    end    
  end

  def create_train
    puts MENU[:type]
    type = gets.chomp.to_i
    return unless [1, 2].include?(type)

    begin
      puts "Введите номер поезда\n 
      Формат номера \"777-77\" (Номер может состоять из букв и цифр)"
      name = gets.chomp
      @trains << PassengerTrain.new(name) if type == 1
      @trains << CargoTrain.new(name) if type == 2
      puts "Создан поезд #{@trains[-1].number}"
    rescue => exception
      puts exception
      retry      
    end    
  end

  def create_route    
    return error 'Создайте 2 станции' if @stations.size < 2 

    begin
      @stations.each_with_index { |station, i| puts "#{i} - #{station.name}" }
      puts 'Выберите начальную станцию'
      start = gets.chomp.to_i    
      puts 'Выберите конечную станцию'
      finish = gets.chomp.to_i
      @routes << Route.new(Station.all[start], Station.all[finish])
    rescue => exception
      puts exception
      retry
    end
      
    
  end

  def create_wagon
    puts MENU[:type]
    type = gets.chomp

    case type
    when '1'
      puts 'Укажите кол-во мест'
      num = gets.chomp
      @wagons << PassengerWagon.new(num) if type == 1 
    when '2'
      puts 'Укажите общий объем вагона'
      num = gets.chomp
      @wagons << CargoWagon.new(num) if type == 2
    end
  end

  def create_all
    @wagons << Wagon.new('passenger')
    @wagons << Wagon.new('cargo')
    @trains << Train.new('001-01', 'passenger')
    @trains << Train.new('002-01', 'cargo')
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

  def error(message)
    puts message
    enter = gets    
  end
end
