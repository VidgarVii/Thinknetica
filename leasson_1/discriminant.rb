# d = b**2-4ac
# x = -(b)/2*a
# x1 = (-(b)+Math.sqrt(d))/2*a
# x2 = (-(b)-Math.sqrt(d))/2*a

puts 'Научная компания "Рога и костыли" приветствует Вас'
puts 'На этот раз мы будем вычислять дискриминант и корни уравнения'
puts 'Введите 3 числа'
print 'a = '
a = gets.chomp.to_i
print 'b = '
b = gets.chomp.to_i
print 'c = '
c = gets.chomp.to_i
puts ''

d = b**2-4*a*c
puts d

if d > 0
  x1 = (-(b)+Math.sqrt(d))/2*a
  x2 = (-(b)-Math.sqrt(d))/2*a
  puts "Дискриминант - #{d}\n 2 корня:\n x1 = #{x1.round(2)}\n x2 = #{x2.round(2)}"
elsif d == 0
  x = -(b)/2*a
  puts "Дискриминант - #{d}\n 1 корень - #{x}"
else  
  puts "Корней нет"
end