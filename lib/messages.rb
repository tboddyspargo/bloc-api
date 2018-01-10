require_relative 'helpers'
module Messages
	# @function																		get_messages
	# @description																This function will return the first (or specified) page of 10 message threads, along with the total number of threads available.
	# @param				{Integer} 			page					The page of message threads (10 per page) to return.
	# @return 			{Array<Hash>} 			
	def get_messages(page=1)
		response = self.class.get "/message_threads", headers: { 'authorization': @auth_token }
		Helpers.parse_response(response)
	end
	
	# @function																		create_message
	# @description																This function will submit an http post request with a message to send to a student's mentor.
	# @param				{Hash}				options					The 'options' has should contain key value pairs corresponding to a Bloc message submission. If submitting to an existing thread, a 'token' and 'stripped-text' key are required. If submitting a new thread, a 'subject', 'recipient_id', and 'message' are required.
	def create_message(options = {})
		defaults = if options.has_key?(:message) && !options.has_key?(:'stripped-text') && !options.has_key?('stripped-text') then
			{}.merge!({'stripped-text': options.delete(:message)})
		else
			{}
		end
		message = defaults.merge!(options).delete_if {|k,v| v.nil? || v.to_s.empty?}
		
		valid_with_token = message.has_key?(:token)
		valid_new_thread = !message.has_key?(:token)  && message.has_key?(:recipient_id) && message.has_key?(:subject)
		has_message = message.has_key?(:'stripped-text') || message.has_key?('stripped-text')
		
		if (valid_with_token || valid_new_thread) && has_message
			response = self.class.post '/messages', body: message, headers: { 'authorization': @auth_token }
			Helpers.parse_response(response, message)
		else
			raise "The message options were not valid. #{message}"
		end
	end
end