module Helpers
	# @function
	# @description												A private function to handle HTTP requests that return JSON data.
	# @param {HTTPartyResponse} response	The response object returned by the HTTParty gem's HTTP requests.
	# @return {Hash|Array}								A hash or array containing the body of the HTTP response (if successful).
	def Helpers.parse_response(response)
    body = JSON.parse response.body
    if response.code == 200
    	body
    else
    	raise "There was a problem retrieving an authentication token. '#{body['message']}'"
    end
	end 
end