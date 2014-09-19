class QueryHashBuilder
	def initialize(querystring_params)
		@querystring_params = querystring_params
	end

	def build
    	if @querystring_params
      		return {:pid => PID_CONST}.merge(@querystring_params)
    	else
      		return {:pid => PID_CONST}
    end
  end
end