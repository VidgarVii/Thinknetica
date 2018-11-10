require_relative 'context.rb'

class Menu
  def initialize
    @adapter = Adapter.new
    menu(:main)          
  end  

  def menu(position = :main)
    puts MENU[position]
    puts '5 - начать сначало'
    puts 'Для выхода из меню нажмите Enter'
    choice = gets.chomp.to_i
    
    #Вызываем метод, который будет обрабатывать запросы
    send(position(choice))
  end

  private

  def main(choice)
    case choice
    when 1 then menu(:create)
    when 2 then menu(:action)
    when 3 then @adapter.stations
    when 5 then menu(:main)
    end    
  end

  def create
    
  end
  
  
  
end