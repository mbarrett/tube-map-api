class TubeStationRepository
	@@data = File.read("public/json/tubestations.json")

	def Get
	  	json_data = @@data

	  	data = JSON.parse(json_data)
		stations = data['TubeStation'].map { |ts| TubeStation.new(ts['name'], ts['lat'], ts['long'], ts['zone']) }

		return stations
	end
end