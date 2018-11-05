triangle = []

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

def pifagor? (triangle)
  triangle.map! { |x| ( x ** 2 ) }
  c = triangle.max
  triangle.delete c

  c == triangle.sum
end 

def isosceles? (triangle)
  check = triangle.uniq
  check.size == 2  
end

def rectangular? (triangle)
  check = triangle.uniq
  check.size == 1
end

puts 'Ваш треугольник является равнобедренным и равносторонним, но не прямоугольный.' if rectangular?(triangle)
puts 'Ваш треугольник является равнобедренным!' if isosceles?(triangle)
puts 'Прямоуго́льный треуго́льник' if pifagor?(triangle)
