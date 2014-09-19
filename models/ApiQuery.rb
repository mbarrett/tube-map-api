class ApiQuery
	attr_accessor :http_method, :method_to_call, :querystring_params, :body_params

	def initialize(http_method, method_to_call, querystring_params, body_params)
		@http_method, @method_to_call, @querystring_params, @body_params = http_method, method_to_call, querystring_params, body_params
	end
end