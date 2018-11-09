puts "Добро пожаловать в наш фитнес спа шугаринг салон!\n\
Мы поможем вам рассчитать Ваш идеальный вес.\n\
Пожалуйста, скажите как Вас зовут?"
name = gets.chomp
puts "Здравствуйте #{name}\nТеперь укажите какой у вас рост в см."
weight = gets.chomp.to_i
puts "Рост - #{weight}"

idial_weight = weight - 110
return puts "#{name}, Ваш вес уже оптимальный" if idial_weight <= 0

puts "#{name}, Ваш идиальный вес - #{idial_weight}"
