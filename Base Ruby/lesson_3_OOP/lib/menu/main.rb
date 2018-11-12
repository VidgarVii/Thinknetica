require_relative 'context.rb'
puts WELOCOME

class Menu
  def initialize(adapter)
    @adapter = adapter
    puts quests
    answer
    call_action
    Menu.new(@adapter)
  end  

  def quests
    MENU[:main] 
  end

  protected
 # Надо добавить проверку левых чисел
  def answer
    puts "9 - Вернуться в главное меню\n0 - Выйти из программы."
    @answer = gets.chomp.to_i
    Menu.new(@adapter) if @answer == 9            #костыль
    abort if @answer.zero?
  end

  def call_action
    case @answer
    when 1 then MenuCreate.new(@adapter)
    when 2 then choice
    when 3 then @adapter.puts_all
    end
  end

  def choice
    puts 'Выберите объект:'
    puts MENU[:choice]
    answer
    TrainMenu.new(@adapter) if @answer == 1
    RouteMenu.new(@adapter) if @answer == 2
  end  
end
