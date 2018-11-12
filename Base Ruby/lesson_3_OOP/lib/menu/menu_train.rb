class TrainMenu < Menu
  def initialize(adapter)
    @adapter = adapter
    puts "Меню управления поездами \nСписок ваших поездов:"
    @adapter.trains.each_with_index do |train, i|
      puts "#{i} - #{train.number} : #{train.class}"
    end
    puts 'Выберите порядковый номер поезда'
    @train = gets.chomp.to_i
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
    when 1 then @adapter.assign_route_train(@adapter.trains[@train])
    when 2 then @adapter.hook_wagon(@adapter.trains[@train])
    when 3 then @adapter.unhook_wagon(@adapter.trains[@train])
    when 4 then @adapter.move(@adapter.trains[@train])
    end
  end  
end
