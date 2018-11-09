class CargoTrain < Train
	def initialize(number)
		super(number)
	end

	def hook_wagon(wagon)
		return unless right_type?(wagon)
		super(wagon)
	end

	protected
#протектед, так как согласно конвенции мы указываем, что ниже методы 
# доступны для переопредения

#Данный метод не является интерфейсом класса поезд. Он служит только как 
# вспомогательный, проверочный метод для прицепки вагонов
	def right_type?(wagon)
		wagon.class == CargoWagon
	end	
end