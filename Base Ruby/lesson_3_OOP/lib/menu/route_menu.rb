class RouteMenu < Menu
  def initialize(adapter)
    @adapter = adapter
    @choice = nil
    p @adapter
    puts "Меню управления маршрутами \nВыберите действие"
    puts quests
    answer(4)
    call_action
    Menu.new(@adapter)
  end  

  def quests
    MENU[:create] 
  end

  protected

  def call_action
    case @answer
    when 1 then @adapter 
    end
  end

  def choice
  end  
end