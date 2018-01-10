module Helpers
	# @function														parse_response
	# @description												A private function to handle HTTP requests that return JSON data.
	# @param {HTTPartyResponse} response	The response object returned by the HTTParty gem's HTTP requests.
	# @return {Hash|Array}								A hash or array containing the body of the HTTP response (if successful).
	def Helpers.parse_response(response, payload={}, headers={})
    body = JSON.parse response.body unless response.body.empty?
    if response.code == 200
    	body || true
    else
    	raise "There was a problem resolving the request. (#{response.code}) '#{body['message']}'. '#{payload}'. '#{headers}'"
    end
	end 
end