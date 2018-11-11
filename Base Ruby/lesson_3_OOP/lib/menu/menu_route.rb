class RouteMenu < Menu
  def initialize(adapter)
    @adapter = adapter
    @choice = nil
    puts "Меню управления маршрутами \nВыберите действие"
    puts quests
    answer(2)
    call_action
    Menu.new(@adapter)
  end  

  def quests
    puts 'Список ваших маршрутов:'
    @adapter.routes.each_with_index { |route, i| puts "#{i} - #{route}"}
    MENU[:route] 
  end

  protected

  def call_action
    case @answer
    when 1 then choice('add')
    when 2 then choice('del')
    end
  end

  def choice(action)
    puts 'Выберите порядковый номер маршрута'
    route = gets.chomp.to_i
    puts 'Выберите порядковый номер станции'

    if action == 'add'      
      @adapter.stations.each_with_index { |state, i| 
        puts "#{i} - #{state.name}" }
      state = gets.chomp.to_i
      @adapter.add_state_to_route(state, route)
    elsif action == 'del'
      return puts 'Вы не можете удалить станцию в маршруте из 2х станций' if @adapter.routes[route].stations.size == 2

      @adapter.routes[route].stations.each_with_index { |state, i| 
        puts "#{i} - #{state.name}" }
      state = gets.chomp.to_i
      @adapter.rm_state_from_route(state, route)
    end
  end  
end