class TimeSlot
	attr_accessor :time, :securityid, :points, :offerids

	def initialize(time, securityid, points, offerids)
		@time, @securityid, @points, @offerids = time, securityid, points, offerids
	end
end