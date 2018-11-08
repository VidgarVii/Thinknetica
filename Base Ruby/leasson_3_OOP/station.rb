=begin
+ Имеет название, которое указывается при ее создании
+ Может принимать поезда (по одному за раз)
+ Может возвращать список всех поездов на станции, находящиеся в текущий момент
+ Может возвращать список поездов на станции по типу (см. ниже): кол-во грузовых, пассажирских
+ Может отправлять поезда (по одному за раз, при этом, поезд удаляется из списка поездов, находящихся на станции). 
=end
require_relative 'train'

class Station
  attr_reader :list_train

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


train = Train.new('01', 'freight', 10)
train2 = Train.new('02', 'passenger', 15)
train3 = Train.new('03', 'passenger', 15)
state = Station.new 'A'
state.add_train(train)
state.add_train(train2)
state.add_train(train3)
p state.list_train_for_type('passenger')
#p state.list_train
