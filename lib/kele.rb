require 'httparty'
require 'json'
require 'pry'

class Kele
	include HTTParty
	base_uri 'https://www.bloc.io/api/v1'
	
	def initialize(email, password)
		response = self.class.post "/sessions", body: {email: email, password: password}
		@auth_token = parse_response(response)['auth_token']
	end
	
	def get_me
		response = self.class.get "/users/me", headers: { authorization: @auth_token }
		parse_response(response)
	end
	
	# @function
	# @description This function will return the availability of a student's mentor.
	# @param {int} mentor_id The id of the mentor whose availability you want to check.
	# @return {hash}  
	def get_mentor_availability(mentor_id)
		response = self.class.get "/mentors/#{mentor_id}/student_availability", headers: { authorization: @auth_token }
		parse_response(response)
	end
	
	private
	def parse_response(response)
		body = JSON.parse response.body
		if response.code == 200
			body
		else
			raise "There was a problem retrieving an authentication token. '#{body['message']}'"
		end
	end
end