module CheckObject
  def check_wagon!(wagon)
    raise 'Выбор не корректен' unless %w(Wagon PassengerWagon CargoWagon).include?(wagon.class.to_s)
  end

  def check_train!(train)
    raise 'Выбор не корректен' unless %w(Train PassengerTrain CargoTrain).include?(train.class.to_s)
  end

  def error(message)
    puts message
    enter = gets    
  end

  def do_have_corgo_wagon?
    @wagons.find { |wagon| wagon.class == CargoWagon } ? true : false
  end

  def check_space_in_wagon!(wagon)
    raise ' Мест нет' if wagon.free.zero?
  end
  
  def is_there_space?(train)
    count_seats = 0
    train.each_wagons do |wagon|
      count_seats += wagon.free
    end
    count_seats.zero? ? false : true
  end
end
