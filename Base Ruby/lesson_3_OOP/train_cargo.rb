class CargoTrain < Train
	def initialize(number)
		super(number)
	end

	def hook_wagon(wagon)
		return unless right_type?(wagon)
		super(wagon)
	end

	protected

	def right_type?(wagon)
		wagon.class == CargoWagon
	end	
end