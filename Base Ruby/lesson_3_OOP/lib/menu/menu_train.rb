class TrainMenu < Menu
  def initialize(adapter)
    @adapter = adapter
    p @adapter
    puts "Меню управления поездами \nВыюерите действие"
    puts quests
    answer
    call_action
    Menu.new(@adapter)
  end  

  def quests
    MENU[:train]
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