class TrainMenu < Menu
  def initialize(adapter)
    @adapter = adapter
    p @adapter
    puts "Меню управления поездами \nВыюерите действие"
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
    @choice = ?
  end  
end