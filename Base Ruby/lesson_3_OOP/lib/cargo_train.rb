class CargoTrain < Train
  @validations = Train::validations
  
  def initialize(number)
    super(number, 'cargo')
  end
end
