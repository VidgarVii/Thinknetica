puts "Задача 1" # Предпочитаю символы, так как работют быстрей
months = {January: 31, February: 28, March: 31, April: 30, May:31, June: 30, July: 31, August: 31, September: 30, October: 31, November: 30, December: 31}

months.each do |month, day|
  puts month if day == 30
end

puts "\nЗадача 2"
array = (10..100).to_a.reject{ |x| x%5 != 0 } 
p array
array2 = (10..100).step(5).to_a
p array2

puts "\nЗадача 3 Фибоначи" #0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89

fibonachi = [0, 1]
 
fibonachi.each_with_index do |single, index|
  if single < 100
    fibonachi[index + 1] = single + fibonachi[index - 1]
  end
end
p fibonachi

puts "\nЗадача 4"

check = %w(а е и я ю э у ы о)
alfavit = (:а..:я).to_a
pos = (1..32).to_a

hash = Hash[[alfavit, pos].transpose]
total = {}
hash.each { |k, v| 
  if check.include?(k.to_s)
    total[k] = v
  end
}
p total
