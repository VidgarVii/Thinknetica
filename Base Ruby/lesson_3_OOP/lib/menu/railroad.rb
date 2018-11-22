  class RailRoad
  include CheckObject
  attr_reader :wagons

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
      puts MENU[:for_booking][1] if do_have_corgo_wagon?
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
    when '3' then choice_train
    when '4' then puts_all
    when '5'
      return unless do_have_corgo_wagon?

      choice_cargo_wagon
    end
  end

  def puts_all
    system('clear')
    print 'Список поездов:'
    @trains.each { |train| show_train(train) }

    puts "\nСписок станций:"
    @stations.each_with_index do |item, index| 
      puts "#{index} - #{item.name} : Список ожидающих поездов: "

      item.each_trains do |train|
        puts "# #{train.number}, #{train.type}, кол-во вагонов - #{train.wagons.size}" 
        train.each_wagons { |wagon| puts about_wagon(wagon) }
      end  
    end

    print 'Список маршрутов:'
    @routes.each_with_index do |route, index| 
      print "\n#{index} - "
      route.puts_stations
     end

    puts "\nСписок вагонов:"
    @wagons.each { |wagon| puts about_wagon(wagon) }
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

  def choice_train
    system('clear')
    return error 'Создайте поезд' if @trains.size.zero?

    begin
      puts 'Выберите поезд'    
      @trains.each_with_index do |train, i|
        puts "#{i} - #{train.number} : #{train.type} : Кол-во вагонов - #{train.wagons.size}"
      end
      train = gets.chomp.to_i
      check_train!(@trains[train])
    rescue => exception
      error exception
      return
    end

    train_menu(@trains[train])
  end

  def choice_cargo_wagon
    system('clear')
    begin
      puts 'Выберите вагон'
      wagons = @wagons.select { |wagon| wagon.class == CargoWagon }
      wagons.each_with_index do |wagon, index|
        puts "#{index} - Товарный вагон ##{wagon.number}. Свободный объем #{wagon.free} м³"
      end
      choice = gets.chomp.to_i
      check_wagon!(wagons[choice])
      check_space_in_wagon!(wagons[choice])
    rescue => exception
      error exception
      return
    end    

    load_in_wagon(wagons[choice])
  end
  
  def train_menu(train) 
    system('clear')
    puts "Выбран #{train.class} : #{train.number}"
    train.each_wagons do |wagon| 
      print "Номер вагона: #{wagon.number} Мест - " 
      puts "Свободно #{wagon.free_volume}/ Занято #{wagon.occupied_volume}" if train.class == CargoTrain
      puts "#{wagon.free_seats}/#{wagon.occupied_seats}" if train.class == PassengerTrain
    end
    puts MENU[:train]
    puts MENU[:for_booking][0] if (train.class == PassengerTrain && train.wagons.size != 0)

    choice = gets.chomp
    
    case choice
    when '1' then assign_route_train(train)
    when '2' then hook_wagon(train)
    when '3' then unhook_wagon(train)
    when '4' then move(train)
    when '5'
      return error 'Мест нет' unless is_there_space?(train)

      book_seats_in_wagon(train) if train.type == 'passenger'     
    end
  end
  
  def book_seats_in_wagon(train)
    train.each_wagons do |wagon|
      unless wagon.free.zero?
        wagon.take_seat 
        return
      end
    end
  end

  def load_in_wagon(wagon)        
    begin
      p wagon
      puts 'Какой объем товаров хотите погрузить?'
      goods_volume = gets.chomp.to_f
      wagon.take_volume(goods_volume)
    rescue => exception
      error exception
      return
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
      error exception
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
      check_wagon!(wagons[wagon])
      train.hook_wagon(wagons[wagon])
    rescue => exception
      error exception
      return
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
      num = gets.chomp.to_i
      @wagons << PassengerWagon.new(num) if num > 0
      @wagons << PassengerWagon.new() if num.zero?
    when '2'
      puts 'Укажите общий объем вагона'
      num = gets.chomp.to_i
      @wagons << CargoWagon.new(num) if num > 0
      @wagons << CargoWagon.new() if num.zero?
    end
  end

  def create_all
    @wagons << PassengerWagon.new
    @wagons << CargoWagon.new
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

  def about_wagon(wagon)
    "# #{wagon.number}, #{wagon.type}, Всего мест - #{wagon.free + wagon.occupied}, Свободные места - #{wagon.free} / Занятых мест - #{wagon.occupied}"    
  end  
end
