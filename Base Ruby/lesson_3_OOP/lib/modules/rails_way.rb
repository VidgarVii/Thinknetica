module Manufactur
  attr_reader :maker

  def maker=(name)
    valid_maker!(name)
    @maker = name    
  end

  protected

  def valid_maker!(name)
    raise 'Название производителя должно содержать больше 3х букв' if name.size < 3
    raise 'Должна быть строка' if name.class != String
  end
end
