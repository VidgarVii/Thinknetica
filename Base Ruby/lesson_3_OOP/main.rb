require_relative 'lib/train'
require_relative 'lib/route'
require_relative 'lib/station'
require_relative 'lib/train_cargo'
require_relative 'lib/train_passenger'
require_relative 'lib/wagon'
require_relative 'lib/wagon_cargo'
require_relative 'lib/wagon_passenger'
require_relative 'lib/menu/adapter'
require_relative 'lib/menu/main'
require_relative 'lib/menu/menu_create'
require_relative 'lib/menu/menu_train'
require_relative 'lib/menu/menu_route'

@adapter = Adapter.new
Menu.new(@adapter)
