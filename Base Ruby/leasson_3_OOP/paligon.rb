require_relative 'train'
require_relative 'route'
require_relative 'station'

st1 = Station.new("Хогвартс")
st2 = Station.new("Дурмстранг")
st3 = Station.new("Шармбатоне")
st4 = Station.new("Кастелобрушу")
route = Route.new(st1, st3)
route.add_station(st2)
route.add_station(st4,1)
route.puts_stations
train = Train.new("001", "passenger", 10)
train.add_or_rm_railwaycar("add")
p train.count_railwaycar
train.add_route(route)

p st1.list_train[0].number
train.add_speed
train.where
train.run 'ahead'
train.where
p st1.list_train
p st4.list_train[0].number
p st2.list_train
p st3.list_train

