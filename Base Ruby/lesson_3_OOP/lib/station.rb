class Station
  include Validation
  include InstanceCounter
  attr_reader :list_train, :name
  validate :name, :presence
  @@stations = []

  def self.all
    @@stations
  end

  def initialize(name)
    @name = name
    validate!
    @@stations << self
    register_instance
    @list_train = []
  end

  def arrive(train)
    @list_train << train
  end

  def departure(train)
    @list_train.delete(train)
  end

  def each_trains
    @list_train.each { |train| yield(train) }
  end

  def list_train_by_type(type)
    # type = passenger || cargo
    trains = @list_train.select { |train| train.type == type }
    trains.each { |train| puts train.number }
  end
end
