puts 'Задача 4'

check = %w[а е и я ю э у ы о]
alfavit = ('а'..'я').to_a
total = {}
alfavit.each_with_index { |k, i| total[k] = i + 1 if check.include?(k) }
p total
