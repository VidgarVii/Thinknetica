require_relative 'lib/train'
require_relative 'lib/cargo_train'
require_relative 'lib/passenger_train'
require_relative 'lib/route'
require_relative 'lib/station'
require_relative 'lib/wagon'
require_relative 'lib/cargo_wagon'
require_relative 'lib/passenger_wagon'
require_relative 'lib/menu/context'
require_relative 'lib/menu/railroad'

menu = RailRoad.new
menu.start
