month_days = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

puts "Введите дату"
print "День:"
day = gets.chomp.to_i
print "Месяц:"
month = gets.chomp.to_i
print "Год:"
year = gets.chomp.to_i

is_leap = ( year % 4 == 0 && year % 100 != 0 || year % 400 == 0 )
month_days[1] = 29 if is_leap

day_number = month_days.take(month - 1).sum + day 
puts "Прошло #{day_number} дня(ей)"
