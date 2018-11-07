puts "Задача 4"

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
