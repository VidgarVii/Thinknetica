module CheckObject
  def check_wagon!(wagon)
    %w(Wagon PassengerWagon CargoWagon).include?(wagon.class)
  end

  def check_train!(train)
    %w(Train PassengerTrain CargoTrain).include?(train.class)
  end

  def error(message)
    puts message
    enter = gets    
  end

  def do_have_corgo_wagon?
    @wagons.find { |wagon| wagon.class == CargoWagon } ? true : false
  end

  def is_there_space?(train)
    count_seats = 0
    train.each_wagons do |wagon|
      count_seats += wagon.free
    end
    count_seats.zero? ? false : true
  end
end
