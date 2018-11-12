class RouteMenu < Menu
  def initialize(adapter)
    @adapter = adapter
    system('cls')
    @choice = nil
    puts "Меню управления маршрутами \nВыберите действие"
    puts quests
    answer
    call_action
    Menu.new(@adapter)
  end  

  def quests
    puts 'Список ваших маршрутов:'
    @adapter.routes.each_with_index { |route, i| puts "#{i} - #{route}" }
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
    if action == 'add'
      @adapter.add_state_to_route(route)
    elsif action == 'del'     
      @adapter.rm_state_from_route(route)
    end
  end  
end