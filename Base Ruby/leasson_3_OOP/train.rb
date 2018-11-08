=begin 
+ Имеет номер (произвольная строка) и 
+       тип (грузовой, пассажирский) и 
+       количество вагонов, эти данные указываются при создании экземпляра класса      
+ Может набирать скорость
+ Может возвращать текущую скорость
+ Может тормозить (сбрасывать скорость до нуля)
+ Может возвращать количество вагонов
+ Может прицеплять/отцеплять вагоны (по одному вагону за операцию, метод просто увеличивает или уменьшает количество вагонов). Прицепка/отцепка вагонов может осуществляться только если поезд не движется.
+ Может принимать маршрут следования (объект класса Route). 
+ При назначении маршрута поезду, поезд автоматически помещается на первую станцию в маршруте.
+ Может перемещаться между станциями, указанными в маршруте. + Перемещение возможно вперед и назад, но только на 1 станцию за раз.
+ Возвращать предыдущую станцию, текущую, следующую, на основе маршрута 
=end
class Train
  attr_reader :speed, :count_railwaycar, :type, :number

  def initialize(number, type, count_railwaycar)
    return unless %w(freight passenger).include?(type)
    @number = number
    @type = type
    @count_railwaycar =  count_railwaycar.to_i
    @speed = 0
    @route = nil
    @index = 0
  end

  def add_speed
    @speed += 10
  end

  def stop
    @speed = 0
  end

  def add_or_rm_railwaycar(action)
    @count_railwaycar = ( action == 'add' ) ? @count_railwaycar.next : @count_railwaycar.pred
  end  

  def add_route(route)
    @route = route
    change_place(@index)
  end  

  def run(direction)
    return puts 'Наберите скорость' if @speed == 0
    if %w(ahead back).include?(direction)
      return puts 'Тупик' if (@index == -1 && direction == 'ahead')
      return puts 'Тупик' if (@index == 0 && direction == 'back')

      direct = (direction == 'ahead') ? 'next' : 'pred'
      change_place(direct)
    else
      puts 'Нет такого направления'
    end
  end
  
  def where   
    puts "Предыдущая станция #{@route.stations[@index - 1].name}" unless @index == 0
    puts "Текущая станция #{@route.stations[@index].name}"
    puts "Следующая станция #{@route.stations[@index + 1].name}" unless @index == -1
  end

  private
  def change_place(place)
    if place == 0
      @route.stations[0].add_train(self)
    else
      @route.stations[@index].send_train(self)
      @route.stations[@index.send(place)].add_train(self)
      @index = 0.send(place)
    end
  end
end
