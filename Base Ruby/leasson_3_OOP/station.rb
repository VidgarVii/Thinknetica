=begin
+ Имеет название, которое указывается при ее создании
+ Может принимать поезда (по одному за раз)
+ Может возвращать список всех поездов на станции, находящиеся в текущий момент
+ Может возвращать список поездов на станции по типу (см. ниже): кол-во грузовых, пассажирских
+ Может отправлять поезда (по одному за раз, при этом, поезд удаляется из списка поездов, находящихся на станции). 
=end
class Station
  attr_reader :list_train, :name

  def initialize(name)
    @name = name
    @list_train = []
  end
  
  def add_train(train)
    @list_train << train
  end
  
  def send_train(train)
    @list_train.delete(train)
  end

  def list_train_for_type (type)    
    trains = @list_train.reject{ |train| train.type != type }
    puts "#{trains.size} поезд(а,ов)"
    trains
  end  
end
