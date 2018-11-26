class PassengerTrain < Train
  validate :number, :format, /^\w{3}-?\w{2}$/

  def initialize(number)
    super(number, 'passenger')
  end
end
