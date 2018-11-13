class RouteMenu < Menu
  def initialize(adapter)
    @adapter = adapter
    system('cls')
    @choice = nil
    puts "Меню управления маршрутами \nВыберите действие"
    puts quests
    answer
    puts 'Выберите порядковый номер маршрута'
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
    route = gets.chomp.to_i
    case @answer
    when 1 then @adapter.add_state_to_route(route)
    when 2 then @adapter.rm_state_from_route(route)
    end
  end
end
