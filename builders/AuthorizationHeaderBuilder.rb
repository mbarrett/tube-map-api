class AuthorizationHeaderBuilder
	def initialize(http_method, method_to_call, querystring_params)
		@http_method = http_method
		@method_to_call = method_to_call
		@querystring_params = querystring_params
	end

	def build
    	return "OAuth realm=\"http://www.opentable.com/\", oauth_consumer_key=\"#{KEY_CONST}\", oauth_signature_method=\"#{SIGNITURE_METHOD_CONST}\", oauth_signature=\"#{signature}\", oauth_timestamp=\"#{timestamp}\", oauth_token=\"\", oauth_nonce=\"#{nonce}\", oauth_version=\"1.0\""
    end

    def signature
    	key ="#{SECRET_CONST}&"
    	custom_uri_escape(Base64.encode64("#{OpenSSL::HMAC.digest('sha1',key, signature_base_string)}").chomp)
  	end

  	def signature_base_string
  		@http_method + '&' + custom_uri_escape("#{URL_CONST}#{@method_to_call}") + '&' +
        	custom_uri_escape(signature_query_string)
  	end

	def signature_query_string
    	#basic parameters for our oauth implementation
    	signature_hash = {
        	:oauth_consumer_key => KEY_CONST,
        	:oauth_nonce => nonce,
	        :oauth_signature_method => SIGNITURE_METHOD_CONST,
	        :oauth_timestamp => timestamp,
	        :oauth_token => "",
	        :oauth_version => '1.0',
	        :pid => PID_CONST.to_s
	    }
	    signature_hash = signature_hash.merge(@querystring_params) if @querystring_params
	    sorted = signature_hash.sort_by { |key, val| key.to_s }
	    query_string = String.new
	    sorted.each do |array|
	      escaped_key = custom_uri_escape(array[0].to_s)
	      escaped_val = custom_uri_escape(array[1].to_s)
	      query_string.concat("#{escaped_key}=#{escaped_val}&")
	    end
	    #chop the last & off
	    return query_string[0..-2]
	end

  	def timestamp
    	"#{Time.now.to_i}"
  	end

  	def nonce
    	@nonce ||= "#{rand(999999999)}"
  	end

  	def custom_uri_escape(string)
    	URI.escape(string, /[^abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\-\_\.\~]/)
  	end
end