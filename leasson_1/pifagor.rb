triangle = []

def pifagor triangle
  triangle.map!{ |x| (x**2).round(2)  }
  c = triangle.max
  triangle.delete c
  p triangle
  sum = triangle.sum
  puts 'PIFAGOR' if c == sum
  
end

puts 'Научная компания "Рога и костыли" приветствует Вас'
puts 'Мы поможем Вам определить тип Вашего треугольника'
puts 'Введите длину каждой стороны треугольника'
puts '       . '
puts '      / \ '
puts '   a /   \ b '
puts '    /_____\ '
puts '       c '
print 'a = '
triangle << gets.chomp.to_f
print 'b = '
triangle << gets.chomp.to_f
print 'c = '
triangle << gets.chomp.to_f
check = triangle.uniq

case check.size
when 2 
  puts 'Ого Ваш треугольник является равнобедренным!'
  pifagor triangle
when 1 then puts 'Ваш треугольник является равнобедренным и равносторонним, но не прямоугольный.' 
else
  pifagor triangle
end 

