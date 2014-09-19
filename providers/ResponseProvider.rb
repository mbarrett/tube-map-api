class ResponseProvider
	def initialize(query)
		@query = query
	end

	def get_response
		api_url = "#{URL_CONST}#{@query.method_to_call}"
		authorization_header = AuthorizationHeaderBuilder.new(@query.http_method, @query.method_to_call, @query.querystring_params).build
		query_hash = QueryHashBuilder.new(@query.querystring_params).build

		puts "Calling: #{api_url}"
		puts
		puts "With header: #{authorization_header}"
		puts
		puts "With hash: #{query_hash}"

		if(@query.http_method == 'GET')
			return HTTParty.get(api_url,
					        	{
					            	:headers =>
					            		{
					            			'Authorization' => authorization_header,
					            			'Connection' => 'close'
					            		},
					            	:query => query_hash
					        	})
		else
			puts "With body params: #{@query.body_params}"
			puts

			HTTParty.post(api_url,
				        	{
				            	:headers =>
				            		{
				            			'Authorization' => authorization_header,
				            			'Connection' => 'close'
				            		},
				            	:query => query_hash,
				            	:body => @query.body_params
				        	})
		end
	end
end