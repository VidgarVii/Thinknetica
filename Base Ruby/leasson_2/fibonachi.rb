puts "Задача 3 Фибоначи" #0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89

fibonachi = [0, 1]
 
fibonachi.each_with_index do |single, index|
  if single < 100
    fibonachi[index + 1] = single + fibonachi[index - 1]
  end
end
p fibonachi
