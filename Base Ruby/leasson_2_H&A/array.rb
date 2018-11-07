puts "Задача 2"
array = (10..100).to_a.reject{ |x| x%5 != 0 } 
p array
array2 = (10..100).step(5).to_a
p array2
