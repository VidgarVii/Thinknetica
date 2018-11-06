class Item
  attr_accessor :name, :price

  def initialize (name, price)
    self.name, self.price = name.to_s, price.to_f
  end  
end

class Cart  
  def initialize *item
    @cart = []   
  end

  def add (item, count)
    @cart << [item, count]
  end
  
  def look
    @cart
  end
end

class Store  
  def initialize
    @cart = Cart.new    
    pay
    check 
  end
  
  def pay
    loop do
      puts 'Что покупаем? (Когда закончите покупки напишите "stop")'
      name = gets.chomp.downcase
      break if name == 'stop'

      puts 'По какой цене?'
      price = gets.chomp.to_f

      puts 'Кол-во'
      count = gets.chomp.to_f
      item = Item.new(name, price)
      @cart.add( item, count )     
    end
  end

  def check # name => {price => count}, .....
    check = {}
    total = 0
    puts 'Товар : Цена : Кол-во'
    @cart.look.each do |item, count|
      check[item.name] = { item.price => count }  
      
      puts "#{item.name}:  #{item.price} * #{count}"

      total += item.price * count
    end
    puts "Итого к оплате: #{total}"
    puts check
  end
end

Store.new
