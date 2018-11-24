puts 'Научная компания "Рога и костыли" приветствует Вас'
puts 'На этот раз мы будем вычислять дискриминант и корни уравнения'
puts 'Введите 3 числа'
print 'a = '
a = gets.chomp.to_f
print 'b = '
b = gets.chomp.to_f
print 'c = '
c = gets.chomp.to_f

d = b**2 - 4 * a * c

if d.negative?
  puts "\n Корней нет"
  abort
else
  x1 = ((-b + Math.sqrt(d)) / 2 * a).round(2)
  x2 = ((-b - Math.sqrt(d)) / 2 * a).round(2)
end

if x1 == x2
  puts "\n Дискриминант - #{d} \n 1 корень - #{x1}"
else
  puts "\n Дискриминант - #{d} \n 2 корня:\n x1 = #{x1}\n x2 = #{x2}"
end
