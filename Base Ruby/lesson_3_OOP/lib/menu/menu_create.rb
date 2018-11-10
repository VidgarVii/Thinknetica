class MenuCreate < Menu
  def initialize(adapter)
    @adapter = adapter
    @choice = nil
    p @adapter
    puts "Меню создания объектов \nВыюерите объект"
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
    when 1 then @adapter.mk_station
    when 2 then @adapter.mk_train('pass') 
    when 3 then @adapter.mk_route  
    when 4 then @adapter.mk_wagon('pass')    
    end
  end

  def choice
    @choice
  end  
end