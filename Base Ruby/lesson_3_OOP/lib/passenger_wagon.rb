class PassengerWagon < Wagon
  attr_reader :free_seats, :occupied_seats

  def initialize(seats=30)
    super('passenger')
    @free_seats = seats
    @occupied_seats = 0    
  end

  def take_seat
    check_free_seats!
    @occupied_seats +=1
    @free_seats -= 1    
  end
  
  private

  def check_free_seats!
    raise 'Мест нет' if @free_seats == 0
  end
end
