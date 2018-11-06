class Calendar
  attr_accessor :day, :month, :year
  
  def initialize (day, month, year)
    self.day, self.month, self.year = day, month, year   
  end
  
  def bis_sextus?
    year = self.year.to_i
    ( year %4 == 0 && year %100 != 0 || year %400 == 0 )
  end

  def total_days
    days = bis_sextus? ? 366 : 365
    return days
  end

  def calendar
    count_day = bis_sextus? ? 29 : 28
    months = {January: 31, February: count_day, March: 31, April: 30, May:31, June: 30, July: 31, August: 31, September: 30, October: 31, November: 30, December: 31}
    return months
  end

  def cont_days
    days = []
    calendar.each_value { |v| days << v } 
    count = days[0..self.month-1].inject(:+) - ( days[self.month-1] - self.day )
    return count
  end 
end

class Game
  def self.start
    puts "Введите дату"
    date = {}
    data = [ ['День', (1..31)], ['Месяц', (1..12)], ['Год', (1900..3000)] ]

    data.each do |single|
      
      loop do
        print "#{single[0]}: "
        get = gets.chomp.to_i
        puts "Диапозон чисел от #{single[1].begin} до #{single[1].end}" unless single[1].include?(get)
        date[single[0]] = get
        break if single[1].include?(get)
      end
    end

    c = Calendar.new(date['День'], date['Месяц'], date['Год'])
    puts "Прошло #{c.cont_days} дня(ей)"
  end
end

Game.start
