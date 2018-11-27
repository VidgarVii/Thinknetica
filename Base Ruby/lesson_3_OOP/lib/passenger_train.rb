class PassengerTrain < Train
  @validations = Train::validations
  
  def initialize(number)
    super(number, 'passenger')
  end
end
