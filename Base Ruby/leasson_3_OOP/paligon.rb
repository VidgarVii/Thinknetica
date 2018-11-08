require_relative 'train'
require_relative 'route'
require_relative 'station'

st1 = Station.new("Хогвартс")
st2 = Station.new("Дурмстранг")
st3 = Station.new("Шармбатоне")
route = Route.new(st1, st3)
route.add_station(st2)
route.puts_stations
