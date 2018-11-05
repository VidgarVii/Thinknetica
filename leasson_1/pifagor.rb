triangle = []

def pifagor triangle
  triangle.map!{ |x| (x**2)  }
  c = triangle.max
  triangle.delete c
  p triangle
  p triangle.sum
  puts 'Прямоуго́льный треуго́льник' if c == triangle.sum
  
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
triangle << gets.chomp.to_i
print 'b = '
triangle << gets.chomp.to_i
print 'c = '
triangle << gets.chomp.to_i
check = triangle.uniq

case check.size
when 2 
  puts 'Ого Ваш треугольник является равнобедренным!'
  pifagor triangle
when 1 then puts 'Ваш треугольник является равнобедренным и равносторонним, но не прямоугольный.' 
else
  pifagor triangle
end 

