class TubeStation
	attr_accessor :name, :lat, :long, :zone

	def initialize(name, lat, long, zone)
		@name, @lat, @long, @zone = name, lat, long, zone
	end
end