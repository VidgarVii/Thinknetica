puts 'Задача 2'
array = (10..100).to_a.select { |x| (x % 5).zero? }
p array
array2 = (10..100).step(5).to_a
p array2
