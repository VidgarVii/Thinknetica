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
    puts 'Список ваших поездов:'
    @adapter.routes.each_with_index { |route, i| puts "#{i} - #{route}"}
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