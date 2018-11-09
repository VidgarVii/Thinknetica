cart = {}

def total_price(cart)
  check = 0
  cart.each_value do |item|
    check += item[:price] * item[:count]
  end
  check
end

loop do
  puts 'Что покупаем? (Когда закончите покупки напишите "stop")'
  name = gets.chomp.downcase
  break if name == 'stop'

  puts 'По какой цене?'
  price = gets.chomp.to_f
  puts 'Кол-во'
  count = gets.chomp.to_f
  cart[name.to_sym] = { price: price, count: count }
end

p cart
puts "Общая цена: #{total_price(cart)}"
