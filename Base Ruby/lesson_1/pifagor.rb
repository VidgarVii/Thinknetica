triangle = []

puts "Научная компания \"Рога и костыли\" приветствует Вас \n\
Мы поможем Вам определить тип Вашего треугольника \n\
Введите длину каждой стороны треугольника"
puts '       
             .
            / \
         a /   \ b
          /_____\
             c '

print 'a = '
triangle << gets.chomp.to_f
print 'b = '
triangle << gets.chomp.to_f
print 'c = '
triangle << gets.chomp.to_f

def pifagor? (triangle)
  triangle.map! { |x| (x**2) }
  c = triangle.max
  triangle.delete c
  c == triangle.sum
end

def isosceles?(triangle)
  check = triangle.uniq
  check.size == 2
end

def rectangular?(triangle)
  check = triangle.uniq
  check.size == 1
end

print 'Ваш треугольник является '
puts 'равнобедренным и равносторонним, не прямоугольный.' if rectangular?(triangle)
puts 'равнобедренным.' if isosceles?(triangle)
puts 'прямоуго́льным' if pifagor?(triangle)
