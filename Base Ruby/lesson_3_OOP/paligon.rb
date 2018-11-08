require_relative 'train'
require_relative 'route'
require_relative 'station'

st1 = Station.new("Хогвартс")
st2 = Station.new("Дурмстранг")
st3 = Station.new("Шармбатоне")
st4 = Station.new("Кастелобрушу")
route = Route.new(st1, st3)
route.add_station(st2, 1)
route.add_station(st4, 2)
route.puts_stations
train = Train.new("001", "passenger", 10)
train.rm_railwaycar
p train.count_railwaycar
train.add_route(route)
train.add_speed
p train.current_station.name
train.move_forward
p train.current_station.name
