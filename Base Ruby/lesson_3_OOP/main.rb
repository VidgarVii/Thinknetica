require_relative 'train'
require_relative 'route'
require_relative 'station'
require_relative 'train_cargo'
require_relative 'train_passenger'
require_relative 'wagon'
require_relative 'wagon_cargo'
require_relative 'wagon_passenger'
require_relative 'adapter'

st1 = Station.new('Хогвартс')
st2 = Station.new('Дурмстранг')
st3 = Station.new('Шармбатоне')
st4 = Station.new('Кастелобрушу')
route = Route.new(st1, st4)
route.add_station(st2, 1)
route.add_station(st3, 2)
route.puts_stations

wp = PassengerWagon.new
wc = CargoWagon.new
tp = PassengerTrain.new '001'
tc = CargoTrain.new '002'
