puts "Задача 3 Фибоначи" #0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89

fibonachi = [0, 1]

loop do 
  next_element = fibonachi[-2] + fibonachi[-1]
  break if next_element > 100
  fibonachi << next_element
end

p fibonachi