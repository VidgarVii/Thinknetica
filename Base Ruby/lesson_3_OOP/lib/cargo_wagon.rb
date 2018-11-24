class CargoWagon < Wagon
  attr_reader :free_volume, :occupied_volume
  alias free free_volume
  alias occupied occupied_volume

  def initialize(volume = 86.4)
    super('cargo')
    @free_volume = volume
    @occupied_volume = 0
  end

  def take_volume(volume)
    check_free_volume!(volume)
    @free_volume -= volume
    @occupied_volume += volume
  end

  private

  def check_free_volume!(volume)
    raise 'Мест нет' if (@free_volume - volume).negative?
  end
end
