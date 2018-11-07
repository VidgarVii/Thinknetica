puts "Задача 4"

check = %w(а е и я ю э у ы о)
alfavit = ('а'..'я').to_a
total = {}
alfavit.each_with_index { |k, i| 
  if check.include?(k)
    total[k] = i+1
  end
}
p total
